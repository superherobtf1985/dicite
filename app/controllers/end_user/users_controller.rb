class EndUser::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    @orders = Order.where(user_id: current_user.id)
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def unsubscribe
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      shippings = Shipping.where(user_id: @user).first
      shippings.last_name = @user.last_name
      shippings.first_name = @user.first_name
      shippings.last_kana_name = @user.last_kana_name
      shippings.first_kana_name = @user.first_kana_name
      shippings.postal_code = @user.postal_code
      shippings.prefecture = @user.prefecture
      shippings.city = @user.city
      shippings.building = @user.building
      shippings.save
      redirect_to user_path(@user)
    else
      @orders = Order.where(user_id: current_user.id)
      @favorites = Favorite.where(user_id: current_user.id)
      render :show
    end
  end

  def destroy
    Favorite.where(user_id: current_user.id).destroy_all
    Review.where(user_id: current_user.id).destroy_all
    current_user.destroy
    redirect_to root_path
  end

  def complete
  end

  private
  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_kana_name, :first_kana_name, :postal_code, :prefecture, :city, :building, :phone, :email)
  end
end
