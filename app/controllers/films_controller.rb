class FilmsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_film_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @films = Film.all
  end

  def new
    @film = Film.new
  end

  def show
    @film = Film.find(params[:id])
    @reviews = @film.reviews.recent.paginate(:page => params[:page], :per_page =>5)
  end

  def edit
  end

  def create
    @film = Film.new(film_params)
    @film.user = current_user

    if @film.save
      current_user.join!(@film)
      redirect_to films_path
    else
      render :new
    end
  end

  def update
    if @film.update(film_params)
      redirect_to films_path, notice: "更新成功！"
    else
      render :edit
    end
  end

  def destroy
    @film.destroy

    redirect_to films_path, alert: "电影已删除！"
  end

  def join
    @film = Film.find(params[:id])

    if !current_user.is_member_of?(@film)
      current_user.join!(@film)
      flash[:notice] = "加入本电影讨论区成功！"
    else
      flash[:warning] = "你已经是本电影讨论区成员了！"
    end

    redirect_to film_path(@film)
  end

  def quit
    @film = Film.find(params[:id])

    if current_user.is_member_of?(@film)
      current_user.quit!(@film)
      flash[:notice] = "已退出本电影讨论区！"
    else
      falsh[:warning] = "你不是本电影讨论区成员，怎么退出 XD"
    end

    redirect_to film_path(@film)
  end

  private

  def find_film_and_check_permission
    @film = Film.find(params[:id])

    if current_user != @film.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def film_params
    params.require(:film).permit(:title, :description)
  end
end
