class RenamePostalcodeColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :postalcode, :postal_code
  end
end
