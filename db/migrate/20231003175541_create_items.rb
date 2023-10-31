class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :brand
      t.string :colour
      t.boolean :is_sold
      t.datetime :sold_at
      t.string :condition
      t.float :price
      t.string :department
      t.string :category
      t.string :sub_category
      t.string :size

      t.timestamps
    end
  end
end
