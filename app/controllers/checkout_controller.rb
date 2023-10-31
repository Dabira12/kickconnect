class CheckoutController < ApplicationController


    def confirm
            uuid = UUID.new
        
            flw = Flutterwave.new("FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X","FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X", "FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X")

            transactions = Transactions.new(flw)
            response = transactions.verify_transaction params[:transaction_id]
            if response['data']['status'] === "successful" 
            @message = 'successful'
            else
                @message = 'unsuccessful'
            end

            puts @message
        
    end


    def pay 
        @listing = Listing.find(params[:id])



        @address_exists = current_user.address.any?

      puts @address_exists


    end

    def address_modal

    end


end 