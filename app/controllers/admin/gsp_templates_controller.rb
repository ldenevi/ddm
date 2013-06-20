class Admin::GspTemplatesController < ApplicationController
  before_filter :use_ckeditor, :only => [:show, :new]
  before_filter :editable, :only => [:show, :new]
  layout false, :only => [:show_readonly]

  def editable
    @is_editable = true
  end
  
  def index
  end
  
  def list
    @templates = GspTemplate.all
  end
  
  def new
    @template = GspTemplate.new
    @agencies = Agency.find(:all, :order => 'id')
  end
   
  def create
    tasks = []
    if params["tasks"]
      params["tasks"].each do |k, v|
        tasks << v
      end
    end
    
    attrs = params[:template].merge({:tasks => tasks.to_json})
    template = GspTemplate.create attrs
    redirect_to :action => 'new'
  end
    
    # TODO: DRY this up. These three methods are repeated in TemplatesController
    def show
      @template = GspTemplate.find(params[:id])
      render 'shared/standard/show'
    end
    
    def show_readonly
      @template = GspTemplate.find(params[:id])
      render "shared/standard/templates/readonly/show"
    end
    
    def update
      @template = GspTemplate.find(params[:id])
      @template.tasks = params[:tasks].map { |k, v| v }.to_json
      @template.save!
      @template.update_attributes(params[:gsp_template])
      redirect_to :back
    end
  
end
