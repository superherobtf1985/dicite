class EndUser::CartsController < ApplicationController
  before_action :authenticate_user!

  def create
    cart = Cart.new(cart_params)
    exists_item = Cart.find_by(item_id: cart_params[:item_id])

    if exists_item.blank?
      if cart.item.stock >= cart.count
        cart.user_id = current_user.id
        if cart.save
          flash[:notice] = 'カートに追加されました'
        end
      end
    else
      exists_item.count += cart_params[:count].to_i
      if cart.item.stock >= exists_item.count
        if exists_item.save
          flash[:notice] = 'カートに追加されました'
        end
      end
    end
    redirect_to carts_path
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    flash[:notice] = 'カートの商品を削除しました'
    redirect_to items_path
  end

  def show
    @carts = Cart.where(user_id: current_user.id)
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    redirect_to "/carts"
  end

  private
  def cart_params
    params.require(:cart).permit(:count, :item_id)
  end
end
