class Trial::OrganizationController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new params[:organization]
    current_user.organization = @organization

    puts current_user.inspect

    if @organization.save && current_user.save
      flash[:notice] = {:success => ["Created #{@organization.full_name}"]}
    else
      flash[:alert] = @organization.errors.messages.merge(current_user.errors.messages)
      redirect_to :back
    end
  end
end
