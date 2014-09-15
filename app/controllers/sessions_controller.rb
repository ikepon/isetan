class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Welcome to isetan"
      redirect_to user
    else
      flash.now[:danger] = 'メールアドレス、パスワードの組み合わせに誤りがあります。'
      render 'new'
    end
  end

  def destroy
  end
end
