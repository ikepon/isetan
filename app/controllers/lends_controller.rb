class LendsController < ApplicationController
  def index
    company_account = User.where(role: 2)
    @company_collections = Collection.where(user: company_account).order(created_at: :desc).page(params[:page]).per(7)
  end

  def show
    @collection = Collection.find(params[:id])
    @book = @collection.book
  end
end