class AddTerminalTrackingUrlToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :terminal_carrier_tracking_url, :string
    add_column :orders, :terminal_tracking_url, :string

  end
end
