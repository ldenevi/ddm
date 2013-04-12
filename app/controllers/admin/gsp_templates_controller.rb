class Admin::GspTemplatesController < ApplicationController
  before_filter :use_ckeditor, :only => [:show, :new]
  before_filter :editable, :only => [:show, :new]

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
  
  def show
    @template = GspTemplate.find(params[:id])
    # @tasks = JSON.parse(@template.tasks)
    render 'shared/standard/show'
  end
  
end
