class AddChargeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :delivery_charge, :integer, default: 500
  end
end
