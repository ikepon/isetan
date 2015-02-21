class Mypage::ProfileController < ApplicationController
  before_action :signed_in_user

  layout 'mypage'

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to edit_mypage_profile_url
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :image, :image_cache, :sign_in_count, :current_sign_in_at)
  end
end
