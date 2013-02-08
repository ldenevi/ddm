class HomeController < ApplicationController
  def index
    @user = current_user
  end
  
  def house
    render :text => "ASDSADSD"
  end
end
