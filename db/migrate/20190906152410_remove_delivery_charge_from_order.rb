class RemoveDeliveryChargeFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :delivery_charge, :string
  end
end
