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
  
  # Deploy review to organizations work flow
  def new_review
    purchased_template = PurchasedTemplate.find(params[:purchased_template_id])
    @review = Review.new(:purchased_template => purchased_template)
    tasks = begin
      JSON.parse(purchased_template.tasks).map do |t|
        Task.new(t)
      end
    end
    
    @review.tasks = tasks
    @review.save!
  end
  
  def deploy_review
    @review = Review.find(params[:review_id])
    @target_organizations = params[:target_organization_ids]
    @target_organizations.each do |to|
      
    end
  end
end
