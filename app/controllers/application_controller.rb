class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def destroy
    sign_out current_user 
    redirect_to new_user_session_path, alert: "Welcome! You have log out successfully."
  end
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  
  def after_sign_out_path_for(resource)
    root_path  
  end

  protected
  # Add this code
  def set_flash_message_for_login
    flash.now[:notice] = "Welcome! You have signed up successfully."
    user_path(resource)
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
  end
end
