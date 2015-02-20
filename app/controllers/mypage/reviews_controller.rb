class Mypage::ReviewsController < ApplicationController
  before_action :review_user, only: [:edit, :update]

  layout 'mypage'

  def index
    @reviews = current_user.reviews.order(created_at: :desc).page(params[:page]).per(7)
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new

    @collections = current_user.books.pluck(:title, :id)
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:success] = '感想を投稿しました'
      redirect_to mypage_review_path(@review)
    else
      @collections = current_user.books.pluck(:title, :id)

      render :new
    end
  end

  def edit
    @review = current_user.reviews.find(params[:id])
  end

  def update
    @review = current_user.reviews.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = '感想を更新しました'
      redirect_to mypage_review_path(@review)
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :evaluation, :collection_id)
  end

  def review_user
    review = Review.find(params[:id])
    redirect_to root_path unless current_user?(review.user)
  end
end
