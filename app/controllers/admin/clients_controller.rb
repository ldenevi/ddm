class Admin::ClientsController < ApplicationController
  
  def index
    @organizations = Organization.where(:type => nil).order("created_at DESC").includes(:users).all
  end

  def add_organization
    @organization = Organization.create params[:organization]
    unless @organization.valid?
      flash[:errors] = @organization.errors.full_messages
      redirect_to :back
    else
      render :template => 'admin/clients/view'
    end
  end

  def view
    @organization = Organization.includes(:users).find(params[:id])
  end

  def add_user
    @organization  = Organization.find(params[:organization_id])
    @user = User.new(params[:user])
    @user.organization = @organization
    respond_to do |format|
      format.html do
        unless @user.save
          flash[:errors] = @user.errors.full_messages
          redirect_to :action => 'view', :id => params[:organization_id]
        else
          flash[:notice] = "Created #{@user.email} for #{@organization.name}"
          render :template => 'admin/clients/view'
        end
      end
      format.json do
        if @user.save
          render :json => {:success => true, :user => @user.attributes}
        else
          render :json => {:success => false, :errors => @user.errors}
        end
      end
    end
  end

  def delete_user
    @organization = Organization.find(params[:organization_id])
    begin
      @organization.users.find(params[:user_id]).destroy
    rescue $!
      flash[:errors] = [$!.message]
    end
    respond_to do |format|
      format.html do
        if flash[:errors].nil?
          render :template => 'admin/clients/view', :id => params[:organization_id]
        else
          redirect_to :action => :view, :id => params[:organization_id]
        end
      end
      format.json do
        if flash[:errors].nil?
          render :json => {:success => true}
        else
          render :json => {:success => false, :errors => flash[:errors]}
        end
      end
    end
  end

  def delete_organization
    begin
      @organization = Organization.find(params[:id])
      @organization.users.destroy_all
      @organization.destroy
    rescue $!
      flash[:errors] = [$!.message]
    end
    respond_to do |format|
      format.html do
        if flash[:errors].nil?
          flash[:notice] = "Deleted '#{@organization.name}'"
          index
          render :template => 'admin/clients/index'
        else
          redirect_to :action => :index
        end
      end
      format.json do
        if flash[:errors].nil?
          render :json => {:success => true, :notice => "Deleted '#{@organization.name}'"}
        else
          render :json => {:success => false, :errors => flash[:errors]}
        end
      end
    end
  end
  
  def purchase_template
    begin
      @organization = Organization.find(params[:organization_id])
      template = GspTemplate.find(params[:gsp_template_id])
      @organization.users.first.purchase_template(template.id)
    rescue $!
      flash[:errors] = [$!.message]
    end
    respond_to do |format|
      format.html do
        if flash[:errors].nil?
          flash[:notice] = "Purchased '#{template.full_name}' for #{@organization.name}"
          render :template => 'admin/clients/view'
        else
          redirect_to :action => :view, :id => @organization.id
        end
      end
    end
    
  end
end
