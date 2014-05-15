class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :store_location

  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  #filter_paramater_logging :card_number, :card_verification
  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  if (request.fullpath != "/users/sign_in" &&
    request.fullpath != "/users/sign_up" &&
    request.fullpath != "/users/password" &&
    request.fullpath != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
  session[:previous_url] = request.fullpath 
end
end


def after_sign_in_path_for(resource)
  session[:previous_url] || root_path
end

protected

def configure_permitted_parameters
 devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :full_name, :address_line1, :address_line2, :city, :state, :zip, :country) }
 devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:full_name, :email, :password, :password_confirmation, :current_password, :address_line1, :address_line2, :city, :state, :zip, :country) }
end

end