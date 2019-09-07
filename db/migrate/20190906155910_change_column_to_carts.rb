class ChangeColumnToCarts < ActiveRecord::Migration[5.2]
  def up
    change_column :carts, :count, :integer, null: false, default: 1
  end

  # 変更前の状態
  def down
    change_column :carts, :count, :integer
  end
end
