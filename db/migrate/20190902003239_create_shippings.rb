class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.integer :user_id
      t.string :postal_code
      t.string :prefecture
      t.string :city
      t.string :building
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :first_kana_name
      t.string :last_kana_name

      t.timestamps
    end
  end
end
