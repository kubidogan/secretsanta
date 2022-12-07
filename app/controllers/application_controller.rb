class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  def logged_in?
    session[:user_id]
  end

  def require_login
    redirect_to controller: 'sessions', action: 'new' unless logged_in?
  end
end
