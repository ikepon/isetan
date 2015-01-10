class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new

    @keyword = params[:keyword]

    if @keyword.present?
      Amazon::Ecs.debug = true
      @res = Amazon::Ecs.item_search(params[:keyword],
          :search_index => 'Books',
          :response_group => 'Medium',
          :country        => 'jp'
      )
    else
      return
    end
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
    params.require(:book).permit(:title, :asin)
  end
end
