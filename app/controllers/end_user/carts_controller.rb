class EndUser::CartsController < ApplicationController

  def create
    cart = Cart.new(cart_params)
    cart.user_id = current_user.id

    if cart.item.stock >= cart.count
      cart.save
      redirect_to "/carts"
    else
      render :show
    end
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    redirect_to items_path
  end

  # def update
  #   @cart = Cart.find(params[:id])
  # end

  def show
    @carts = Cart.where(user_id: current_user.id)
  end

  private
  def cart_params
    params.require(:cart).permit(:count, :item_id)
  end
end
