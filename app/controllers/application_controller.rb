class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_login
  
  def check_login
    redirect_to new_user_session_path if current_user.nil?
  end
end
