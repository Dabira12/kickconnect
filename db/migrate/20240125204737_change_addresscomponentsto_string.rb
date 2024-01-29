class ChangeAddresscomponentstoString < ActiveRecord::Migration[7.0]
  def change
   change_column :addresses, :google_address_components, :string
  end
end
