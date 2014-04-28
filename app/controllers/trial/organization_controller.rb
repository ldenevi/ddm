class Trial::OrganizationController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new params[:organization]
    current_user.organization = @organization
    if @organization.save && current_user.save
      flash[:notice] = ["Created #{@organization.full_name}"]
      redirect_to eicc_declaration_index_path
    else
      flash[:alert] = @organization.errors.messages.merge(current_user.errors.messages)
      redirect_to :back
    end
  end
end
