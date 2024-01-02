class OrderController < ApplicationController

    require 'nanoid'

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
        flw = Flutterwave.new("FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X","FLWSECK_TEST-bc051d6049a3f37b4f52dd749f6943b5-X", "FLWPUBK_TEST-26fe5dfee2bacfdf308d5dae58eead95-X",true)

        @txref = Nanoid.generate(size:14 )

        puts @txref

        transactions = Transactions.new(flw)

       
        response = transactions.verify_transaction 4735557

        puts response['data']['meta']['listing_id']

      
        @user = User.find(current_user.id)
        current_listing = Listing.find(params[:id])
       
       
      

        @addresses = Address.where(user_id:current_user.id)
        @default_address = Address.find_by(user_id:current_user.id, id:current_user.default_address_id)
        @address_exists = current_user.addresses.any?
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


end 