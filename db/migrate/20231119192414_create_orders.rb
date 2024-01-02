class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :listing_id
      t.string :status
      t.integer :listing_price
      t.integer :shipping_paid
      t.integer :service_fee
      t.integer :order_total

      t.timestamps
    end
  end
end
