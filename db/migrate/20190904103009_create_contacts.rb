class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :subject
      t.text :contacts
      t.text :reply_contents

      t.timestamps
    end
  end
end
