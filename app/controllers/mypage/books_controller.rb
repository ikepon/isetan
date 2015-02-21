class Mypage::BooksController < ApplicationController
  before_action :signed_in_user

  def create
    book = Book.new(book_params)
    book.collections.build(user_id: current_user.id)
    if book.save
      flash[:success] = '蔵書登録しました'
      @collection = Collection.where(book_id: book.id, user_id: current_user.id)
      redirect_to mypage_collection_path(@collection.id)
    else
      render 'confirm'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :asin, :book_cover, :remote_book_cover_url)
  end
end
