class EndUser::PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @carts = Cart.where(user_id: current_user.id)
  end

  def create_shipping
    @shipping = Shipping.new(shipping_params)
    @shipping.user_id = current_user.id

    if @shipping.save
      flash[:notice] = '配送先が追加されました'
      redirect_to new_payments_path
    else
      @carts = Cart.where(user_id: current_user.id)
      render :new
    end
  end

  def confirm
    @carts = Cart.where(user_id: current_user.id)
    @order = Order.new
    @order.how_to_pay = params[:how_to_pay]
    @order.shipping_id = params[:shipping_id]
    if @order.shipping_id == nil
      render :new
    else
      @shipping = Shipping.find(@order.shipping_id)
    end
  end

  def complete
    shipping = Shipping.find(params[:shipping])
    @carts = Cart.where(user_id: current_user.id)
    if are_sale(@carts)
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
        total_money: calc_total_price(@carts)
        # shipping_status:
      )
      order.save

      @carts.each do |cart_item|
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
        item = Item.find(cart_item.item.id)
        item.stock -= cart_item.count

        if item.stock == 0
          item.status = "sold_out"
        end
        item.save
        order_item.save
        cart_item.destroy
        item = Item.find(cart_item.item_id)
        item.stock -= 1
        item.save
      end
    else
      flash[:notice] = '在庫が足りないため、購入できません'
      render :new
    end
  end

  private
  # def order_params
  #   params.require(:order).permit(:how_to_pay, :shipping_id)
  # end

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

  def are_sale(carts)
    carts.each do |cart|
      item = Item.find(cart.item_id)
      if (item.status == 'sold_out') || (cart.count.to_i > item.stock.to_i)
        return false
      end
    end
    return true
  end
end
