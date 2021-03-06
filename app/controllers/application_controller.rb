class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :store_path
  before_filter :check_login, :except => :validate_single_eicc_spreadsheet

  def check_login
    return true if ENV['RAILS_ENV'] == 'test'
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

  def after_sign_in_path_for(resource)
    if current_user.is_a?(Trial::TrialUser)
      cfsi_cmrt_index_path
    else
      session[:return_to] || root_path
    end
  end

private
  def store_path
    session[:return_to] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def clear_store_path
    session[:return_to] = nil
  end

  def redirect_back_or_to(alternate)
    redirect_to(session[:return_to] || alternate)
    clear_stored_location
  end

end
