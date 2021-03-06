class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :sidebar

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_url, notice: "ログインしてください"
    end
  end

  def sidebar
    @sidebar_news = News.order(created_at: :desc).limit(3)
    @sidebar_reviews = Review.eager_load(:user).order(created_at: :desc).limit(3)
    @sidebar_collections = Collection.eager_load(:book, :user).order(created_at: :desc).limit(3)
  end
end
