class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_login
  after_filter  :store_path

  def check_login
    redirect_to new_user_session_path if current_user.nil?
  end
  
  def check_browser
    supported_browsers = {:chrome => 25, :firefox => 8, :ie => 10, :safari => 20, :opera => 8}
    useragent = UserAgent.parse(request.env["HTTP_USER_AGENT"])
    @is_browser_supported = (supported_browsers[useragent.browser.downcase.to_sym] && (useragent.version.to_a[0] >= supported_browsers[useragent.browser.downcase.to_sym]))
    
    @is_browser_supported = true
    @browser_info = request
  end
  
protected
  def use_ckeditor
    @use_ckeditor = true
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
