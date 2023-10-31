class RenameItemsToListings < ActiveRecord::Migration[7.0]
  def change
    rename_table :items, :listings
  end
end
