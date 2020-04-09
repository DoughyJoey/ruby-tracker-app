class ApplicationController < ActionController::Base
  # ensures the user is authenticated before using the application
    before_action :authenticate_user!
  # permits a user to add additional parameters with devise
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      # permits a user to sign up with their first and last name
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      # permits a user to edit their accounts first and last name
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end  

end
