class RemoveLocationState < ActiveRecord::Migration[7.0]
  def change
    remove_column :listings, :location_state
  end
end
