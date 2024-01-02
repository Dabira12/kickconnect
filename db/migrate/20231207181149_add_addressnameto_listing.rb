class AddAddressnametoListing < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :sender_address, :string
  end
end
