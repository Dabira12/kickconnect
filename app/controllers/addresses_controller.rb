class AddressesController < ApplicationController


def new
    @address = current_user.addresses.build
    # @address.build_user
    @User = User.find(current_user.id)
    puts params

    url = URI(request.referrer).path
    split_url = url.split('/')
    
    
    if split_url.include?('order') && split_url.include?('listings')
      
      @reload_page = true
    else
      @reload_page = false
    end
end

def put

end

def show
  @address = Address.all

end

def index
  @addresses = Address.where(user_id:current_user.id)
  @user = User.find(current_user.id)

  url = URI(request.referrer).path
  split_url = url.split('/')
    

  if split_url.include?('order') && split_url.include?('listings')
      
    @reload_page = true
  else
    @reload_page = false
  end

  
  # if @user.saved_change_to_addresses_id
   
  #   render turbo_stream: turbo_stream.replace("address", partial:"home/header")
  # end
end


def listing_index
    @addresses = Address.where(user_id:current_user.id)
    @listing = Listing.find(params[:id])
    
   
end 

def create
  @address = current_user.addresses.build(address_params)
  @user = User.find(current_user.id)


  puts params
  if @address.save
      # @user.default_address_id = @address.id
        User.update(@user.id,:default_address_id=> @address.id)
        
        # turbo_stream.replace("pay_button", partial:"order/pay_button")
      render turbo_stream: [ turbo_stream.replace("address", partial:"addresses/show", locals:{current_address_id: @address.id, default: true, listing_id:nil})]

      # @user = User.find(current_user.id)
      # current_listing = Listing.find(params[:id])
      # current_listing_address = Address.find(current_listing.addresses_id)
     

      # uri = URI('https://delivery.apiideraos.com/api/v2/tariffs/allprice')
      # body = {
      #     type: "local",
      #     toAddress: {
      #       name: @address.name,
      #       email: current_user.email,
      #       address: @address.line1,
      #       phone: current_user.phone_number
      #     },
      #     fromAddress: {
      #       name: current_listing_address.name,
      #       email: User.find(current_listing.user_id).email,
      #       address: current_listing_address.line1,
      #       phone:User.find(current_listing.user_id).phone_number
      #     },
      #     parcels: {
      #       width: 32.5,
      #       length: 32.5,
      #       height: 32.5,
      #       weight: 2
      #     },
      #     items: [
      #       {
      #         name: "item 1",
      #         description: "item 1",
      #         weight: "506.0",
      #         category: "beauty",
      #         amount: "46000000.0",
      #         quantity: "23"
      #       }
      #     ]
      #   }
      # headers = { 'Content-Type': 'application/json', 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGVsaXZlcnktc3RhZ2luZy5hcGlpZGVyYW9zLmNvbVwvYXBpXC92MlwvYXV0aFwvbG9naW4iLCJpYXQiOjE3MDQ3NDcyNDYsImV4cCI6MTcwNTgyNzI0NiwibmJmIjoxNzA0NzQ3MjQ2LCJqdGkiOiJGMERyc1pRM3doWDZvUVZQIiwic3ViIjoxMzksInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.wJBwXBoSOBxCNJYqXdpvkaWX_3TZHDkAVhSMWztSOYg' }
      # response = Net::HTTP.post(uri, body.to_json, headers).then(render turbo_stream: [ turbo_stream.replace("address", partial:"addresses/show", locals:{current_address_id: @address.id, default: true, listing_id:nil})])

      # res= JSON.parse(response.body)

      # @rates = res['data']['rates']

      # puts yessjdj
      # puts @rates
         

      # puts @address.id
      # @user.update_attribute(:default_address_id, @address.id)

      # puts @user.default_address_id
  else
    render :new, status: :unprocessable_entity

  end



end



def show_all
  @address = current_user.addresses
  end

  private
    def address_params
      params.require(:address).permit(:first_name, :last_name, :line1, :zipcode, :line2, :city, :formatted_address, :google_address_components, :state, :state_code, :country_code,:phone_number, :email)
    end
end