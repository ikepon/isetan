class UsersController < ApplicationController
  before_action :set_user, only: %w(show)
  before_action :signed_in_user, only: %w(edit update)
  before_action :correct_user, only: %w(edit update)

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

  def edit
  end

  def update
    # TODO パスワード入力なしでも更新できるように
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :image, :image_cache, :sign_in_count, :current_sign_in_at)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to login_url, notice: "ログインしてください"
    end
  end

  def correct_user
    @user = User.eager_load(:collections).find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
