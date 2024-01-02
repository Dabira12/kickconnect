class AddressesController < ApplicationController


def new
    @address = current_user.addresses.build
    # @address.build_user
    @User = User.find(current_user.id)
end

def put

end

def show
  @address = Address.all

end

def index
  @addresses = Address.where(user_id:current_user.id)
  @user = User.find(current_user.id)

  
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



  if @address.save
      # @user.default_address_id = @address.id
        User.update(@user.id,:default_address_id=> @address.id)
      render turbo_stream: [turbo_stream.replace("pay_button", partial:"order/pay_button"), turbo_stream.replace("address", partial:"addresses/show", locals:{current_address_id: @address.id, default: true, listing_id:nil})]
         

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
      params.require(:address).permit(:name, :line1, :line2 )
    end
end