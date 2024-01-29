class AddFormattedAddressandAddresscomponents < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :formatted_address, :string
    add_column :addresses, :google_address_components, :text

  end
end
