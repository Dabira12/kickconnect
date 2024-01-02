class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.string :account_number
      t.string :bank_code
      t.string :bank_name
      t.string :benefactor_name

      t.timestamps
    end
  end
end
