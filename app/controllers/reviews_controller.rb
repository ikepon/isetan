class ReviewsController < ApplicationController
  before_action :review_user, only: [:edit, :update]

  def index
    @reviews = Review.page(params[:page]).per(7)
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = '感想を更新しました'
      redirect_to @review
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :review, :evaluation)
  end

  def review_user
    review = Review.find(params[:id])
    redirect_to root_path unless current_user?(review.user)
  end
end
