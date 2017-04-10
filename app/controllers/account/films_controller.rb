class Account::FilmsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.participated_films
  end
end
