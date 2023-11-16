class UsersController < ApplicationController


def edit
   
  end 

def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
       head :ok
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