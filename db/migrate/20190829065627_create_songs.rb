class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :cd_id
      t.integer :number
      t.string :name

      t.timestamps
    end
  end
end
