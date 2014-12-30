class ContactsController < ApplicationController
  def new
    if signed_in?
      user_name = current_user.name
    end

    @contact = Contact.new(user_name: user_name, category: 'ユーザ登録について')
  end

  def confirm
    @contact = Contact.new(contact_params)

    render action: 'show' unless @contact.valid?
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:success] = 'お問合せが完了しました'
      redirect_to complete_contacts_url
    else
      render 'new'
    end
  end

  def complete
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_name, :category, :content)
  end
end
