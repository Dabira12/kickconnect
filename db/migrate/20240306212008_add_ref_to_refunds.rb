class AddRefToRefunds < ActiveRecord::Migration[7.0]
  def change
    add_reference :refunds, :user, foreign_key: true
    add_reference :refunds, :order, foreign_key: true
  end
end
