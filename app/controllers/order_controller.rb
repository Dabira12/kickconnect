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
            current_listing_address = Address.find(current_listing.addresses_id)

            @default_address = Address.find_by(user_id:current_user.id, id:current_user.default_address_id)

            rate_id = params[:rate_id]

            puts response
            if response['data']['status'] === "successful"  && response['data']['meta']['listing_id'] === params[:id] && current_listing.is_sold == false
               

               
            

               order = Order.new(listing_id:current_listing.id, buyer_id: current_user.id, seller_id:current_listing.user.id , buyer_address:@default_address, sender_address:current_listing_address, listing_price:current_listing.price, terminal_rate_id:rate_id, status:'active')
               order.save


                
                res= JSON.parse(response.body)
                   
                shipment_id = params[:shipment_id]
                order.update_attribute(:terminal_shipment_id, shipment_id)
           

                @status = 'successful'

                current_listing.update_attribute(:is_sold, 1)
                
                
                
                    

            puts params[:id]

            else
                @message = 'unsuccessful'
            end

            puts @message
        
    end


    def pay 
        @listing = Listing.find(params[:id])


    end


    def pay_lazy
        @listing = Listing.find(params[:id])
        # flw = Flutterwave.new("FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X","FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X", "FLWSECK_TEST972670b42ec6",true)

        @txref = Nanoid.generate(size:14 )
        

        
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
            

            # uri = URI('https://api.terminal.africa/v1/shipments/quick')
            uri = URI('https://sandbox.terminal.africa/v1/shipments/quick')
            body = {    
                delivery_address: {
                        
                            city: @default_address.city,
                        
                            country: @default_address.country_code,
                            email: @default_address.phone_number,
                            first_name: @default_address.first_name,
                            
                            last_name: @default_address.last_name,
                            line1: @default_address.line1,

                            line2: @default_address.line2,
                        
                            phone: @default_address.phone_number,
                            
                            state: @default_address.state,
                        
                            zip: @default_address.zipcode,
                        
                        },
                pickup_address: {
                        
                            city: current_listing_address.city,
                            country: current_listing_address.country_code,
                            email: current_listing_address.email,
                            first_name: current_listing_address.first_name,
                            
                            last_name: current_listing_address.last_name,
                            line1: current_listing_address.line1,
                            line2: current_listing_address.line2,
                            phone: current_listing_address.phone_number,
                            state: current_listing_address.state,
                            zip: current_listing_address.zipcode,
                            
                        },
                        metadata:{ buyer_id: @user.id, listing_id: @listing.id},
            parcel:{
                    description: 'clothing',
                
                    items: [
                        {
                            description: "Shoes purchased from Shipmonk Store",
                            name: "Rubber Boots",
                            currency: "NGN",
                            value: 25000,
                            weight: 2.5,
                            quantity: 1
                        }
                    ],
                
                    packaging: "PA-FP4S1LW693HVHHV8",
                
                
                    weight_unit: "kg",
                
                    
                
                
            }}
            # headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer sk_live_1TbW7FD0YBcPcvMks29t9OEUBskgi9UR' }
            headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer sk_test_yRZJuyWvH4HALP8upPDcoaEw3JIs0yVO' }

            response = Net::HTTP.post(uri, body.to_json, headers)

            res= JSON.parse(response.body)
            
            @shipment_id = res['data']['shipment_id']
            puts @shipment_id
            # rate_uri = URI('https://api.terminal.africa/v1/rates/shipment')
            rate_uri = URI('https://sandbox.terminal.africa/v1/rates/shipment')
            rate_params = {:shipment_id => @shipment_id}
            rate_uri.query = URI.encode_www_form(rate_params)
            rate_body= {}
            rates_response = Net::HTTP.get_response(rate_uri,headers)
            

            rates_res = JSON.parse(rates_response.body)
        

            if rates_res['status'] == false
                @rates = []
            else
            @rates = rates_res['data']

            end

            @rates == [] ? @can_deliver = false : @can_deliver = true
            end

    end

    def fulfill

        @order= Order.find(params[:id])

        @listing = Listing.find(@order.listing_id)


    end 


    def details
        @order= Order.find(params[:id])
        @seller = User.find(@order.seller_id)
        @buyer = User.find(@order.buyer_id)
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

    def request_courier
        # uri = URI('https://api.terminal.africa/v1/shipments/pickup')
        uri = URI('https://sandbox.terminal.africa/v1/shipments/pickup')
        order = Order.find(params[:id])
        body = {
            rate_id: order.terminal_rate_id,
        }

        # headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer sk_live_1TbW7FD0YBcPcvMks29t9OEUBskgi9UR'}
        headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer sk_test_yRZJuyWvH4HALP8upPDcoaEw3JIs0yVO'}
        puts order.terminal_shipment_id
        response = Net::HTTP.post(uri, body.to_json, headers)
        puts response.body

        begin
            
        rescue 
            puts 'yes'

        end

            puts ('yes')
            flash[:alert] = "Before you create a listing, you must enter your bank account details so we can pay you when your item gets sold!"

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

    def courierselect
        puts params
        @shippingTarget = params[:shippingTarget]
        if params[:courierPrice] == ""
            @courierPrice = 'Please Select a courier'
        else
            @courierPrice = "NGN " + params[:courierPrice]
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