class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.string :item_name
      t.text :jacket_image_id
      t.integer :price
      t.integer :item_count
      t.string :artist_name
      t.string :genre_name
      t.string :label_name

      t.timestamps
    end
  end
end
