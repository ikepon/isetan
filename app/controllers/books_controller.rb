class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @keyword = params[:keyword]

    if @keyword.present?
      Amazon::Ecs.debug = true
      @res = Amazon::Ecs.item_search(params[:keyword],
        search_index:   'Books',
        response_group: 'Medium',
        country:        'jp'
      )
    else
      return
    end
  end

  def confirm
    @book = Book.new

    @asin = params[:asin]

    if Book.find_by(asin: @asin)
      flash.now[:danger] = '既に登録されています。'
      render 'new' and return
    else
      Amazon::Ecs.debug = true
      books = Amazon::Ecs.item_lookup(
        @asin,
        response_group: 'Small, ItemAttributes, Images',
        country: 'jp'
      )
    end

    unless books.items.last.present?
      flash.now[:danger] = '入力いただいたASINコードに該当する本はありません。'
      render 'new' and return
    else
      @book_info = books.items.last
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
