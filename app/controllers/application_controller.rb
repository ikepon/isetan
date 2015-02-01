class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :sidebar

  def sidebar
    @sidebar_news = News.order(created_at: :desc).limit(3)
  end
end
