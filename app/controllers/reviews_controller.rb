class ReviewsController < ApplicationController
  before_action :review_user, only: [:edit, :update]

  def index
    @reviews = Review.page(params[:page]).per(7)
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @books = Book.order('title')
    @review = Review.new(user_id: current_user.id)
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:success] = '感想を投稿しました'
      redirect_to reviews_path
    else
      render :new
    end
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
    params.require(:review).permit(:user_id, :book_id, :title, :review, :evaluation)
  end

  def review_user
    review = Review.find(params[:id])
    redirect_to root_path unless current_user?(review.user)
  end
end