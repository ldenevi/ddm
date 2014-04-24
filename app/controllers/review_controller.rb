class ReviewController < ApplicationController
  layout :false, :except => [:show, :list, :task_list]

  def show
    @review = Review.where(:id => params[:id], :organization_id => current_user.organization.id).first
  end

  # TODO Active and upcoming reviews
  def list
    @reviews = current_user.organization.reviews
  end

  def show_task
    @task = Task.includes({:review => :organization_template}).where("tasks.id = ? AND reviews.organization_id = ?", params[:id], current_user.organization).first
    @comments = @task.comments.reverse
  end

  def active_tasks
    @active_tasks = current_user.active_tasks
  end

  def task_list
    @review = Review.includes(:agency, :tasks => :reviewer).where(:id => params[:id], :organization_id => current_user.organization.id).first
    @tasks  = @review.tasks
  end

  def mark_task_as_completed
    @task = Task.includes(:review).where("tasks.id = ? AND reviews.organization_id = ?", params[:id], current_user.organization).first
    case params[:status]
      when 'conforming'
        @task.conform!
      when 'not_conforming'
        @task.not_conform!
    end
    Notifications::Reviews.task_closed(@task, current_user).deliver
    render :text => 'Done'
  end

  def reopen_task
    @task = Task.includes(:review).where("tasks.id = ? AND reviews.organization_id = ?", params[:id], current_user.organization).first
    @task.reopen!
    Notifications::Reviews.task_reopened(@task, current_user).deliver
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
    @task = Task.includes(:review).where("tasks.id = ? AND reviews.organization_id = ?", params[:task_id], current_user.organization).first
    render :layout => nil
  end

  def post_comment
    @task = Task.includes(:review).where("tasks.id = ? AND reviews.organization_id = ?", params[:task][:id], current_user.organization).first
    @comment = Comment.create params[:comment]

    begin
      if params[:attachment]
        @attachment = BinaryFile.generate :filename => params[:attachment].original_filename, :data => params[:attachment].read, :user => current_user
        @attachment.attachable = @comment
        @attachment.save!
      end

      @task.comments << @comment
      @posted_comment = @comment

      Notifications::Reviews.task_comment_posted(@comment, current_user).deliver

      render :layout => nil, :template => 'review/post_comment_form'

    rescue GSP::FileManager::BinaryFileHandler::InvalidFileFormatException
      flash[:notice] = "'%s' is an invalid file format." % params[:attachment].original_filename
      redirect_to :back
    end
  end

  def show_comment
    @comment = Comment.where(:id => params[:id], :author_id => current_user).first
    render :partial => 'task_comment', :content_type => 'text/html'
  end

  def get_attachment
    @attachment = BinaryFile.where(:id => params[:id]).first
    send_data @attachment.file_data, :filename => @attachment.filename #, :type => @attachment.mime_types.first["Content-Type"]
  end

end
