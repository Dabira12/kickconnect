class AddStatecodetoAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :state_code, :string

  end
end
