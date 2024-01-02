class AddAddresstoListing < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :sender_address, :string
    add_column :orders, :buyer_address, :string

  end
end
