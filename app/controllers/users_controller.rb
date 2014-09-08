class UsersController < ApplicationController
  before_action :set_user, only: %w(show edit update)

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password_digest, :profile, :image, :image_cache)
  end
end
