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
  
  def new
    @template = Template.new
    @agencies = Agency.find(:all, :order => 'acronym')
  end
  
  def create
    render :text => params.inspect
  end
  
end
