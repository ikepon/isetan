class FrontPagesController < ApplicationController
  def index
    @new_reviews = Review.order('created_at desc').limit(2)
  end
end
