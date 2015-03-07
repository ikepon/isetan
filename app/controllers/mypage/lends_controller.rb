class Mypage::LendsController < ApplicationController
  before_action :signed_in_user

  layout 'mypage'

  def index
    @rentals = Collection.rental_books.where(borrower: current_user, status: [1, 2]).page(params[:page]).per(7)
  end
end
