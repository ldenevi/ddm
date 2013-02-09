class OrganizationController < ApplicationController
  def index
    @org  = current_user.organization
    @purchased_templates = @org.purchased_templates
  end

  def hierarchy
    @org = current_user.organization
    render :json => @org.to_ecotree_array
  end

  def overview
    @org = current_user.organization
  end
  
  def templates
    @org = Organization.find(current_user.organization_id, :include => :purchased_templates)
    @templates = @org.purchased_templates
  end
  
  def deploy_reviews
    @org = Organization.find(current_user.organization_id, :include => :purchased_templates)
    @templates = @org.purchased_templates
  end
end
