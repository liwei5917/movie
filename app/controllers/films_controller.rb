class FilmsController < ApplicationController
  def index
    @films = Film.all
  end

  def new
    @film = Film.new
  end
end
