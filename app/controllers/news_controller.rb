class NewsController < ApplicationController
  def index
    @news = News.order(created_at: :desc)
  end

  def show
    @news = News.find(params[:id])
  end
end
