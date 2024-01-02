class AddAddressRefToListing < ActiveRecord::Migration[7.0]
  def change
    add_reference :listings, :addresses, foreign_key: true
  end
end
