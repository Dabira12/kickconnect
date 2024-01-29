class AddFirstNameLastNameToAddress < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :name, :first_name
    add_column :addresses, :last_name, :string
  end
end
