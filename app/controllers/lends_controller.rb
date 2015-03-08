class LendsController < ApplicationController
  def index
    @company_collections = Collection.rental_books.order(created_at: :desc).page(params[:page]).per(7)
  end

  def show
    @collection = Collection.find(params[:id])
    @book = @collection.book
  end
end
