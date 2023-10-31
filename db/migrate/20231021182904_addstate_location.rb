class AddstateLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :location_state, :string
  end
end
