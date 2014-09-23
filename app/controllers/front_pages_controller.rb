class FrontPagesController < ApplicationController
  def index
    @news = News.order('created_at DESC').limit(3)
  end
end
