class BankAccount < ApplicationRecord
    require 'json'
    belongs_to :user


    validates :account_number, :bank_code, :bank_name, presence:true 
    validate :valid_account

    private
        def valid_account
           
            payment = Flutterwave.new("FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X","FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X", "FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X",true)
            misc = Misc.new(payment)

            payload={
                "account_number" => self.account_number,
                "account_bank" => self.bank_code

            }
            begin
                response = misc.resolve_account(payload)
                
            rescue  FlutterwaveServerError  => exception
                puts exception

                errors.add(:base,"We could not verify your bank account info , please ensure you entered the right credentials")
              
               
            rescue => exception
              
             

            else
             
                ans = JSON.parse(response.read_body)
                benefactor_name= ans ['data']['account_name']

                self.benefactor_name = benefactor_name
                
                
            
            end

        end
end
