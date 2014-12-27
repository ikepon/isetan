class ReviewsController < ApplicationController
  def index
    @reviews = Review.page(params[:page]).per(7)
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
  end

  def edit
  end
end
