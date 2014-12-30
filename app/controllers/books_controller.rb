class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = '蔵書登録しました'
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
  end

  def upload
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :isbn)
  end
end
