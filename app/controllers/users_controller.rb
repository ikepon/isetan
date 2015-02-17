class UsersController < ApplicationController
  before_action :set_user, only: %w(show)

  def index
    @users = User.where.not(id: current_user).eager_load(:collections).order(created_at: :desc).page(params[:page]).per(7)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "isetanへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :image, :image_cache, :sign_in_count, :current_sign_in_at)
  end
end
