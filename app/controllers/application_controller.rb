class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?
  #layout :layout_by_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :remember_me, images_attributes: [:avatar]) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, images_attributes: [:avatar]) }
  end

  # def layout_by_resource
  #   if devise_controller? && resource_name == :user && action_name == 'new'
  #     "devise"
  #   else
  #     "application"
  #   end
  # end
  def after_sign_out_path_for(resource)
    new_user_session_path
  end 
end
