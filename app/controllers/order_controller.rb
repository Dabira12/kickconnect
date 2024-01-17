class OrderController < ApplicationController

    require 'nanoid'
    require 'httparty'
    require 'json'

    before_action :can_purchase, only:[:pay]
    before_action :listing_is_sold, only:[:pay, :confirm]
    before_action :can_fulfill, only:[:fulfill]
    def confirm
            uuid = UUID.new
        
            flw = Flutterwave.new("FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X","FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X", "FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X",true)

            transactions = Transactions.new(flw)
            response = transactions.verify_transaction params[:transaction_id]



            current_listing = Listing.find(params[:id])

            puts response
            if response['data']['status'] === "successful"  && response['data']['meta']['listing_id'] === params[:id] && current_listing.is_sold == false
               

               
                current_listing.update_attribute(:is_sold, 1)
                   


                Order.create!(listing_id:current_listing.id, buyer_id: current_user.id, seller_id:current_listing.user.id , buyer_address:current_user.default_address, listing_price:current_listing.price, status:'active')

                @status = 'successful'

                
                    

            puts params[:id]

            else
                @message = 'unsuccessful'
            end

            puts @message
        
    end


    def pay 
        @listing = Listing.find(params[:id])
        # flw = Flutterwave.new("FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X","FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X", "FLWSECK_TEST972670b42ec6",true)

        @txref = Nanoid.generate(size:14 )
        

        puts @txref

        # transactions = Transactions.new(flw)

       
        # response = transactions.verify_transaction 4735557

        # puts response['data']['meta']['listing_id']

      
        @user = User.find(current_user.id)
        current_listing = Listing.find(params[:id])
        current_listing_address = Address.find(current_listing.addresses_id)
       
       
      

        @addresses = Address.where(user_id:current_user.id)
        @default_address = Address.find_by(user_id:current_user.id, id:current_user.default_address_id)
        @address_exists = current_user.addresses.any?
        if @default_address !=nil

        uri = URI('https://delivery-staging.apiideraos.com/api/v2/tariffs/allprice')
        body = {
            type: "local",
            toAddress: {
              name: @default_address.name,
              email: current_user.email,
              address: @default_address.line1,
              phone: current_user.phone_number
            },
            fromAddress: {
              name: current_listing_address.name,
              email: User.find(current_listing.user_id).email,
              address: current_listing_address.line1,
              phone:User.find(current_listing.user_id).phone_number
            },
            parcels: {
              width: 32.5,
              length: 32.5,
              height: 32.5,
              weight: 2
            },
            items: [
              {
                name: "item 1",
                description: "item 1",
                weight: "506.0",
                category: "beauty",
                amount: "46000000.0",
                quantity: "23"
              }
            ]
          }
        headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGVsaXZlcnkuYXBpaWRlcmFvcy5jb21cL2FwaVwvdjJcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNzA1NTI0NTkxLCJleHAiOjE3MDY2MDQ1OTEsIm5iZiI6MTcwNTUyNDU5MSwianRpIjoiMzBYVTNYeEhwUGphSFdyTyIsInN1YiI6Mjg0NywicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.x7Sa9aN4Adzs3YhJMtRPGaARDlVJ1eIJUmPR28awWqg' }
        response = Net::HTTP.post(uri, body.to_json, headers)

        res= JSON.parse(response.body)

        @rates = res['data']['rates']


        valid_rates = find_valid_rates(@rates)

        @sorted_valid_rates = sort_valid_rates(valid_rates)

        end



        # respond_to do |format|
        #     format.html do

        #     format.turbo_stream { render turbo_stream: turbo_stream.prepend('defaultAddress', partial: 'addresses/defaultAddress', locals: {defaultAddress: @default_address}) }

        #     end

        # end

      puts @address_exists


    end

    def fulfill
        @order= Order.find(params[:id])

        @listing = Listing.find(@order.listing_id)


    end 


    def details
        @order= Order.find(params[:id])
        @seller = User.find(@order.seller_id)
    end 

    def purchase_details
        @order= Order.find(params[:id])
        @seller = User.find(@order.seller_id)
    end 

    def can_purchase ## this method makes sure a user cannot try and purchase thier own listing
        @listing = current_user.listings.find_by(id:params[:id]) ## checking if the logged in user owns the current listing
      

        if @listing!=nil ## if the current listing is not nil that means the logged in user owns/ is asscciated with the current listing and should therefore not be able to purchase their own listing
            redirect_to shop_path
        end

     
    end

    def listing_is_sold
        @listing = Listing.find(params[:id])

        if @listing.is_sold == true
            redirect_to shop_path
        end
    end

    def can_fulfill
        order = Order.find(params[:id])
        if order.seller_id != current_user.id
            redirect_to shop_path
        end
    end

    def find_valid_rates(rates)
        valid_rates = Array.new
        for rate in rates
            if rate['status']== true
               
               valid_rates = valid_rates.push(rate)
               
            end
        end
        return valid_rates
    end

    def sort_valid_rates(valid_rates)
        for i in 1...(valid_rates.length)
            j = i
            while j > 0
                if valid_rates[j-1]['amount'] > valid_rates[j]['amount']
                    temp = valid_rates[j]
                    valid_rates[j] = valid_rates[j-1]
                    valid_rates[j-1] = temp
                else
                    break
                end
                j = j - 1
            end
        end
        return valid_rates
    end

   
end 