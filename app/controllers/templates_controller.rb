class TemplatesController < ApplicationController
  def list
    @templates = current_user.organization.organization_templates
  end
  
  def deploy_review
    @template = OrganizationTemplate.find(params[:id])
    @review = @template.deploy_review
    redirect_to :controller => 'home', :action => 'index'
  end
  
  def show
    @template = OrganizationTemplate.find(params[:id])
  end
end
