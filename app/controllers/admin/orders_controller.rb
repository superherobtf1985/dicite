class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_orders_path
    else
      @orders = Order.all
      render :index
    end
  end

  private
  def order_params
    params.require(:order).permit(:shipping_status)
  end
end
