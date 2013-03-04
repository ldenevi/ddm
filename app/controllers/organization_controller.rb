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
  
  def share_template
    pt = OrganizationTemplate.find(params[:purchased_template_id])
    shared = pt.share_among(:all)
    flash[:notice] = "Template shared to %s" % [shared.map { |p| p.organization.full_name }]
    redirect_to :action => 'templates'
  end
  
  # Deploy review to organizations work flow
  def deploy_reviews
    @org = Organization.find(current_user.organization_id, :include => :purchased_templates)
    @templates = @org.purchased_templates
  end
  
  def generate_review
    @review = OrganizationTemplate.find(params[:purchased_template_id]).generate_review
  end
  
  def deploy_review
    # @review = Review.create(params[:review])
  
    # render :text => "<h1>Submitted params</h1><div style='font-family:Courier New; width:1000px'>#{params.inspect}</div><br><br><h1>#{@review.inspect}</h1>"
    # Poof! send off
    purchased_template = OrganizationTemplate.find(params[:review][:purchased_template_id])
    puts "purchased_template.deploy_all_reviews"
    purchased_template.deploy_all_reviews
    redirect_to :action => 'deployed_reviews', :purchased_template_id => params[:review][:purchased_template_id]
  end
  
  def deployed_reviews
    @purchased_template = OrganizationTemplate.find(params[:purchased_template_id])
    @organizations = [@purchased_template.organization] + @purchased_template.children.map(&:organization)
  end
  
  def update_review
    @review = Review.find(params[:review_id])
    @review.update_attributes(params[:review])
    
    redirect_to :back
  end
end
