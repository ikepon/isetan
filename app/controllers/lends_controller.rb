class LendsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]

  def index
    company_account = User.where(role: 2)
    @company_collections = Collection.where(user: company_account).page(params[:page]).per(7)
  end

  def show
  end

  def edit
  end

  def update
  end
end
