class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :line1
      t.string :line2
      t.string :zipcode
      t.boolean :is_residential
      t.string :firstname
      t.string :phone_number
      t.string :email
      t.string :state
      t.string :locality

      t.timestamps
    end
  end
end
