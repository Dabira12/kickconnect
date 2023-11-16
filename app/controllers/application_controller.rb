class ApplicationController < ActionController::Base
   before_action :set_current_user
   before_action :configure_permitted_parameters, if: :devise_controller?


    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      end

   
end
