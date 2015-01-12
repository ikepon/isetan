class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.find(params[:id])
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
    @book.collections.build(user_id: current_user.id)
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

  def collection_params
    params.require(:collection).permit(:user_id, :book_id)
  end
end
