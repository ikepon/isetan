class Mypage::LendsController < ApplicationController
  def index
    @rentals = Collection.rental_books.where(borrower: current_user, status: [1, 2]).page(params[:page]).per(7)
  end
end
