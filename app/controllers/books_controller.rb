class BooksController < ApplicationController
  before_action :book_page

  def index
    @books = Book.order(created_at: :desc).eager_load(:collections).page(params[:page]).per(7)
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_page
    @book_page = true
  end
end
