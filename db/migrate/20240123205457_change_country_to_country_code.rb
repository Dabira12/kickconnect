class ChangeCountryToCountryCode < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :country, :country_code
  end
end
