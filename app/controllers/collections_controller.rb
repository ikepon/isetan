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
    # TODO このアクションのコードは整える
    @book = Book.new

    @asin = params[:asin]

    Amazon::Ecs.debug = true
    books = Amazon::Ecs.item_lookup(
      @asin,
      response_group: 'Small, ItemAttributes, Images',
      country: 'jp'
    )

    unless books.items.last.present?
      flash.now[:danger] = '入力いただいたASINコードに該当する本はありません。'
      render 'new' and return
    end

    @book_info = books.items.last

    collection_book = Book.find_by(asin: @asin)
    user_book = Collection.find_by(user_id: current_user.id, book_id: collection_book.try(:id))

    if user_book
      flash.now[:danger] = '既に蔵書登録されています。'
      render 'new' and return
    elsif collection_book
      @collection = Collection.new(user_id: current_user.id, book_id: collection_book.id)
    else
      render 'books/confirm' and return
    end
  end

  def create
    collection = Collection.new(collection_params)
    if collection.save
      flash[:success] = '蔵書登録しました'
      redirect_to book_path(collection.book_id)
    else
      render 'new'
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:user_id, :book_id)
  end
end
