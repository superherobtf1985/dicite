class AddShippingIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :shipping_id, :integer
  end
end
