class ApplicationController < ActionController::Base
  # before_action :current_user
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  # def current_user
  #   @user = (User.find_by(id: session[:user_id]) || User.new)
  # end

  # def logged_in?
  #   session[:user_id]
  # end

  # def require_login
  #   redirect_to controller: 'sessions', action: 'new' unless logged_in?
  # end
end
