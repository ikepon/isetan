class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def create
  end

  def edit
  end

  def upload
  end

  def destroy
  end
end