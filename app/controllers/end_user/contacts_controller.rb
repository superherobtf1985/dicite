class EndUser::ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save!
      flash[:notice] = "ご意見ありがとうございました。"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:subject, :contacts)
  end
end
