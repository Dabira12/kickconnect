class AddUserToBankAccount < ActiveRecord::Migration[7.0]
  def change
    add_reference :bank_accounts, :user, foreign_key: true
  end
end
