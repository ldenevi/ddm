class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_login
  after_filter  :store_path

  def check_login
    redirect_to new_user_session_path if current_user.nil?
  end

private  
  def store_path
    session[:return_to] = request.fullpath
  end
  
  def clear_store_path
    session[:return_to] = nil
  end
  
  def redirect_back_or_to(alternate)
    redirect_to(session[:return_to] || alternate)
    clear_stored_location
  end
end
