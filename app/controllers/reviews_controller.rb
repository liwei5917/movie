class ReviewsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @film = Film.find(params[:film_id])
    @review = Review.new
  end

  def create
    @film = Film.find(params[:film_id])
    @review = Review.new(review_params)
    @review.film = @film
    @review.user = current_user

    if @review.save
      redirect_to film_path(@film)
    else
      render :new
    end
  end

  def destroy
    @film = Film.find(params[:film_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to account_reviews_path
  end

  def edit
    @film = Film.find(params[:film_id])
    @review = Review.find(params[:id])
  end

  def update
    @film = Film.find(params[:film_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to account_reviews_path
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end

end
