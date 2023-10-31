class AddAddresstoUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :address
  end
end
