class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :artist_id
      t.integer :genre_id
      t.integer :label_id
      t.string :name
      t.text :jacket_image_id
      t.integer :price
      t.integer :stock
      t.integer :status
      t.string :release_date

      t.timestamps
    end
  end
end
