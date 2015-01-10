class SessionsController < ApplicationController
  def new
    redirect_to root_path and return if signed_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Welcome to isetan"
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレス、パスワードの組み合わせに誤りがあります。'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
