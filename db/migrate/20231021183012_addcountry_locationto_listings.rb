class AddcountryLocationtoListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :location_country, :string
  end
end
