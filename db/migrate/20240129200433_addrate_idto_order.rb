class AddrateIdtoOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :terminal_rate_id, :string

  end
end
