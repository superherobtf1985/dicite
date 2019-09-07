class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @orders = Order.where(params[:id])
    @favorites = Favorite.where(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :show
    end
  end

  def destroy
    user = User.find(params[:id])
    Favorite.where(user_id: user.id).destroy_all
    Review.where(user_id: user.id).destroy_all
    user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_kana_name, :first_kana_name, :postal_code, :prefecture, :city, :building, :phone, :email)
  end
end
