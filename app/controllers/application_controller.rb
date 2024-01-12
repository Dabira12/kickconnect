class ApplicationController < ActionController::Base
   
   before_action :set_current_user
   before_action :store_location
   before_action :configure_permitted_parameters, if: :devise_controller?

   def after_sign_in_path_for(resource)
    previous_path = session[:previous_url]
    session[:previous_url] = nil
    previous_path || shop_path
  end

  def after_sign_up_path_for(resource)
    previous_path = session[:previous_url]
    session[:previous_url] = nil
    previous_path || shop_path
  end

  def store_location
   
    if user_signed_in? == false
    
    # json = JSON.parse(request.path_parameters)
    # puts json
    if request.path_parameters[:controller] == 'listings' &&  request.path_parameters[:action] == "show"
        session[:previous_url] = request.path
        puts session[:previous_url]
    end

    end
  end

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:phone_number])
      end

   
end
