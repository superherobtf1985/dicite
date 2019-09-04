class EndUser::PaymentsController < ApplicationController
  def new
    @carts = Cart.where(user_id: current_user.id)
  end

  def create_shipping
    @shipping = Shipping.new(shipping_params)
    @shipping.user_id = current_user.id

    if @shipping.save
      redirect_to new_payments_path
    else
      @carts = Cart.where(user_id: current_user.id)
      render :new
    end
  end

  def confirm
    @carts = Cart.where(user_id: current_user.id)
    @order = Order.new(order_params)
    @shipping = Shipping.find(@order.shipping_id)
  end

  def complete
    shipping = Shipping.find(params[:shipping])
    cart_items = Cart.where(user_id: current_user.id)

    order = Order.new(
      how_to_pay: params[:order],
      delivery_charge: 500,
      postal_code: shipping.postal_code,
      prefecture: shipping.prefecture,
      city: shipping.city,
      building: shipping.building,
      phone: shipping.phone,
      first_name: shipping.first_name,
      last_name: shipping.last_name,
      first_kana_name: shipping.first_kana_name,
      last_kana_name: shipping.last_kana_name,
      user_id: current_user.id,
      total_money: calc_total_price(cart_items)
      # shipping_status:
    )
    order.save

    cart_items.each do |cart_item|
      order_item = OrderItem.new(
        order_id: order.id,
        item_id: cart_item.item.id,
        item_name: cart_item.item.name,
        jacket_image_id: cart_item.item.jacket_image_id,
        price: cart_item.item.price,
        item_count: cart_item.count,
        artist_name: cart_item.item.artist.name,
        genre_name: cart_item.item.genre.name,
        label_name: cart_item.item.label.name
      )
      order_item.save
      cart_item.destroy
    end
  end

  private
  def order_params
    params.require(:order).permit(:how_to_pay, :shipping_id)
  end

  def shipping_params
    params.require(:shipping).permit(:first_name, :last_name, :first_kana_name, :last_kana_name, :postal_code, :prefecture, :city, :building, :phone)
  end

  def calc_total_price(carts)
    sum_price = 0

    carts.each do |cart|
        sum_price += cart.item.price * cart.count
    end

    return sum_price
  end
end
