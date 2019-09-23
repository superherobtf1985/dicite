class ChangeShippingStatusToOrders < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :shipping_status, :integer, default: 0
    change_column :orders, :how_to_pay, :integer, default: 0
  end

  def down
    change_column :orders, :shipping_status, :integer
    change_column :orders, :how_to_pay, :integer
  end
end
