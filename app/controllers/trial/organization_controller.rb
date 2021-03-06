class Trial::OrganizationController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new params[:organization]
    current_user.organization = @organization
    if @organization.save && current_user.save
      flash[:notice] = ["Created #{@organization.name}"]
      redirect_to :controller => 'cfsi/cmrt', :action => 'index'
    else
      flash[:alert] = @organization.errors.messages.merge(current_user.errors.messages)
      redirect_to :back
    end
  end
end
