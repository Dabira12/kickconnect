class FixFulfilledTypo < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :is_fulffiled, :is_fulfilled

  end
end
