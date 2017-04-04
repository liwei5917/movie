class FilmsController < ApplicationController
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
  end

  def create
    @film = Film.new(film_params)
    @film.save

    redirect_to films_path
  end

  private

  def film_params
    params.require(:film).permit(:title, :description)
  end
end
