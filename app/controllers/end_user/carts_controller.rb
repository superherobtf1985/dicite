class EndUser::CartsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = Cart.new(cart_params)
    exists_item = Cart.find_by(item_id: cart_params[:item_id])

    if exists_item.blank?
      if cart.item.stock >= cart.count
        cart.user_id = current_user.id
        cart.save
      end
    else
      exists_item.count += cart_params[:count].to_i
      if cart.item.stock >= exists_item.count
        exists_item.save
      end
    end
    redirect_to "/carts"
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    redirect_to items_path
  end

  def show
    @carts = Cart.where(user_id: current_user.id)
  end

  private
  def cart_params
    params.require(:cart).permit(:count, :item_id)
  end
end
