class TemplatesController < ApplicationController
  def list
    @templates = current_user.organization.purchased_templates
  end
  
  def deploy_review
    @template = PurchasedTemplate.find(params[:id])
    @review = @template.deploy_review
    redirect_to :controller => 'home', :action => 'index'
  end
  
  def show
    @template = PurchasedTemplate.find(params[:id])
  end
end
