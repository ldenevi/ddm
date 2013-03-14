class TemplatesController < ApplicationController
  before_filter :use_ckeditor, :only => [:temporary_template_display]
  before_filter :editable, :only => [:temporary_template_display, :new_task, :destroy_task]

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
  
  # Add custom organization template
  def new_organization_template
    @all_organization_templates_options = current_user.organization.organization_templates.map { |t| [t.full_name, t.id] }
    @copy_source = GspTemplate.find params[:source_template_id] unless params[:source_template_id].nil?
  end
  
  def post_organization_template
  end
  
  def load_organization_template_data
  end
  
  def editable
    @is_editable = true
  end
  
  def temporary_template_display
    @template = get_gsp_or_organization_template(params)  
    render :template => 'shared/standard/show'
  end
  
  def new_task
    @template = get_gsp_or_organization_template(params)
    tasks = JSON.parse(@template.tasks)
    @sequence = tasks.size + 1
    @task = {"name" => 'Insert task name...', "instructions" => 'Insert instructions...'}
    tasks << @task
    @template.tasks = tasks.to_json
    @template.save!
    render :template => 'shared/standard/new_task', :layout => nil
  end
  
  def destroy_task
    @template = get_gsp_or_organization_template(params)
    tasks = JSON.parse(@template.tasks)
    tasks.delete_at(params[:task_sequence].to_i - 1)
    @template.tasks  = tasks.to_json
    @template.save!
    render :text => ''
  end
  
private
  def get_gsp_or_organization_template(params)
    if params[:ot_id]
      OrganizationTemplate.find params[:ot_id]
    elsif params[:t_id]
      GspTemplate.find params[:t_id]
    else
      nil
    end
  end
end
