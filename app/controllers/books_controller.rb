class BooksController < ApplicationController
  before_action :book_page

  def index
    @books = Book.order(created_at: :desc).eager_load(:collections).page(params[:page]).per(7)
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book.collections.build(user_id: current_user.id)
    if @book.save
      flash[:success] = '蔵書登録しました'
      redirect_to @book
    else
      render 'new'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :asin, :book_cover, :remote_book_cover_url)
  end

  def book_page
    @book_page = true
  end
end
