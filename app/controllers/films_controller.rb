class FilmsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @films = Film.all
  end

  def new
    @film = Film.new
  end

  def show
    @film = Film.find(params[:id])
  end

  def edit
    @film = Film.find(params[:id])

    if current_user != @film.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def create
    @film = Film.new(film_params)
    @film.user = current_user

    if @film.save
      redirect_to films_path
    else
      render :new
    end
  end

  def update
    @film = Film.find(params[:id])

    if current_user != @film.user
      redirect_to root_path, alert: "You have no permission."
    end

    if @film.update(film_params)
      redirect_to film_path, notice: "更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @film = Film.find(params[:id])

    if current_user != @film.user
      redirect_to root_path, alert: "You have no permission."
    end
    
    @film.destroy

    redirect_to films_path, alert: "电影已删除！"
  end

  private

  def film_params
    params.require(:film).permit(:title, :description)
  end
end
