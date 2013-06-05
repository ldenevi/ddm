class ReviewController < ApplicationController
  layout :false, :except => [:show, :list, :task_list]
  
  def show
    @review = Review.find(params[:id])
  end
  
  # TODO Active and upcoming reviews
  def list
    @reviews = current_user.organization.reviews
  end
  
  def show_task
    @task = Task.find(params[:id], :include => {:review => :organization_template})
    @comments = @task.comments.reverse
  end
  
  def active_tasks
    @active_tasks = current_user.active_tasks
  end
  
  def task_list
    @review = Review.includes(:agency, :tasks => :reviewer).find(params[:id])
    @tasks  = @review.tasks
  end
  
  def mark_task_as_completed
    @task = Task.find(params[:id])
    @task.complete!
    render :text => 'Done'
  end
  
  def reopen_task
    @task = Task.find(params[:id])
    @task.reopen!
    render :text => 'Done'
  end
  
  def recently_completed_tasks
    @recently_completed_tasks = current_user.recently_completed_tasks
    render :partial => 'review/recently_completed_tasks_panel'
  end
  
  
 # Task comments
  def list_comments
  end
  
  def post_comment_form
    @task = Task.find(params[:task_id])
    render :layout => nil
  end
  
  def post_comment
    @task = Task.find(params[:task][:id])
    @comment = Comment.create params[:comment]
    
    begin
      if params[:attachment]
        @attachment = BinaryFile.generate :filename => params[:attachment].original_filename, :data => params[:attachment].read
        @attachment.attachable = @comment
        @attachment.save!
      end
      
      @task.comments << @comment
      @posted_comment = @comment
      
      render :layout => nil, :template => 'review/post_comment_form'

    rescue GSP::FileManager::BinaryFileHandler::InvalidFileFormatException
      flash[:notice] = "'%s' is an invalid file format." % params[:attachment].original_filename 
      redirect_to :back
    end
  end
  
  def show_comment
    @comment = Comment.find(params[:id])
    render :partial => 'task_comment', :content_type => 'text/html'
  end
  
  def get_attachment
    @attachment = BinaryFile.find(params[:id])
    send_data @attachment.file_data, :filename => @attachment.filename #, :type => @attachment.mime_types.first["Content-Type"]
  end
  
end
