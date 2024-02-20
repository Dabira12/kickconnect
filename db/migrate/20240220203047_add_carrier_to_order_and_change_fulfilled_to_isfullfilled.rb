class AddCarrierToOrderAndChangeFulfilledToIsfullfilled < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :carrier, :string
    rename_column :orders, :fulfilled, :is_fulffiled

  end
end
