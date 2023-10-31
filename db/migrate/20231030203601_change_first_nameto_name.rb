class ChangeFirstNametoName < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :firstname, :name
  end
end
