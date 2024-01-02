class UsersController < ApplicationController


def edit
end 

def create
end

def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      if @user.saved_change_to_default_address_id
   
        render turbo_stream: turbo_stream.replace("address", partial:"addresses/show", locals:{current_address_id: @user.default_address_id, default: true, listing_id:nil})
  
      end
      
      else
        head :unprocessable_entity
      end
end

def show


end

private
    def user_params
      params.require(:user).permit(:default_address_id)
    end

end