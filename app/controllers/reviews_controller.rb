class ReviewsController < ApplicationController
  before_action :review_page

  def index
    @reviews = Review.order(created_at: :desc).page(params[:page]).per(7)
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_page
    @review_page = true
  end
end
