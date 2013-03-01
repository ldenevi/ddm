class Admin::GspTemplatesController < ApplicationController

  def index
  end
  
  def list
    @templates = Template.all
  end
  
  def new
    @template = Template.new
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
    template = Template.create attrs
    redirect_to :action => 'new'
  end
  
  def show
    @template = Template.find(params[:id])
    @tasks = JSON.parse(@template.tasks)
  end
  
end
