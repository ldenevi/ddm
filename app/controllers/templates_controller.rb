class TemplatesController < ApplicationController
  before_filter :use_ckeditor, :only => [:temporary_template_display, :new_organization_template]
  before_filter :editable, :only => [:temporary_template_display, :new_task, :destroy_task, :new_organization_template]
  layout false, :only => [:settings]

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
    render "shared/standard/show"
  end
  
  # Add custom organization template
  #def new_organization_template
  #  @all_organization_templates_options = current_user.organization.organization_templates.map { |t| [t.full_name, t.id] }
  #  @copy_source = GspTemplate.find params[:source_template_id] unless params[:source_template_id].nil?
  #end
  
  # Organization admin/owner can create custom templates
  def new_organization_template
    @agency = Agency.in_house
    @template = OrganizationTemplate.create :agency => @agency, :agency_display_name => @agency.name, :organization => current_user.organization
    render "shared/standard/show"
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
  
  def settings
    @template = OrganizationTemplate.find(params[:id])
    @possible_owners = current_user.organization.users
  end
  
  #
  #
  #  WYSIWYG gsp.TemplateManager.js attributes editor
  # 
  def field_options
    @options = begin
      case params[:field_name]
      
      # Template#frequency string 
      #  
      # This string is used to determine the due dates for Review and its tasks 
      #
      when 'frequency'
        [['Annual', 'Annual'],['Quarterly', 'Quaterly'],['Monthly', 'Monthly'],['Weekly', 'Weekly']]
        
      # Template#agency
      # 
      # A list of agencies which are relevant to the organization.
      # TODO: Make it relevant just to the user's organization and not pull all of them.
      # 
      when 'agency_name'
        Agency.all.map do |agency|
          ["%s (%s)" % [agency.name, agency.acronym], agency.id]
        end
        
      # Review#owner
      # 
      # List of users within an organization who can own/manage reviews
      # TODO: Make it list only users with the power to own/manage reviews
      #
      when 'responsible_party'
        current_user.organization.users.map { |u| [u.eponym, u.id] }
        
      # Task#executor
      #
      # List of users who can execute a task
      # TODO: Make it list only users with the power to execute tasks
      #
      when 'executor'
        current_user.organization.users.map { |u| [u.eponym, u.id] }
        
      else
        [[]]
      end
    end
    
    render :json => @options
  end
  
  # organization template ajax urls
  def ot_update_attributes; update_attributes(OrganizationTemplate, params); end
  def ot_update_task;       update_task(OrganizationTemplate, params);       end
  
  # gsp template ajax urls
  def gspt_update_attributes; update_attributes(GspTemplate, params); end
  def gspt_update_task;       update_task(GspTemplate, params);       end
  
  # review ajax urls
  def review_update_attributes; update_attributes(Review, params); end
  
private
  def update_attributes(object, params)
    template = object.find(params[:id])
    params.delete(:controller); params.delete(:action); params.delete(:id)
    template.update_attributes(params)
    render :nothing => true
  end
  
  def update_task(object, params)
    if (object.is_a?(Review))
      review = Review.find(params[:id])
      task   = review.tasks[params[:task_sequence].to_i - 1]
      task.name = params[:task][:name] unless params[:task][:name].nil?
      task.instructions = params[:task][:instructions] unless params[:task][:instructions].nil?
      task.save!
    else
      template = object.find(params[:id])
      tasks = JSON.parse(template.tasks)
      task_index = params[:task_sequence].to_i - 1
      tasks[task_index] = tasks[task_index].merge(params[:task])
      template.tasks = tasks.to_json
      template.save!
    end
    render :nothing => true
  end
  
public
  def new_task
    @template = get_gsp_or_organization_template(params)
    tasks = (@template.tasks) ? JSON.parse(@template.tasks) : []
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
