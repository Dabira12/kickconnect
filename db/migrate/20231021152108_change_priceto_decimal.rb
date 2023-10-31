class ChangePricetoDecimal < ActiveRecord::Migration[7.0]
  def up
    change_column :listings, :price, :decimal, :precision =>10, :scale =>2
  end

  def down
    change_column :listings, :price, :integer
  end

end 
