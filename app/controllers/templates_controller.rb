class TemplatesController < ApplicationController
  def list
    @templates = current_user.organization.organization_templates
  end
  
  def prepare_review
    @template = OrganizationTemplate.find(params[:id])
    @review   = @template.generate_review
    @possible_review_owner_options  = [[current_user.eponym, current_user.id]]
    @possible_task_executor_options = current_user.organization.users.map { |u| [u.eponym, u.id] }
  end
  
  def deploy_review
    review = Review.create params[:review]
    redirect_to :controller => 'home', :action => 'index'
  end
  
  def show
    @template = OrganizationTemplate.find(params[:id])
  end
end
