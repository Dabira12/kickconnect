class AdddefaultAddresstoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :default_address, :json
  end
end
