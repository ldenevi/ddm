class ReviewController < ApplicationController
  layout :false
  
  def show_task
    @task = Task.find(params[:id], :include => {:review => :organization_template})
  end
  
  def active_tasks
    @active_tasks = current_user.active_tasks
  end
  
  def mark_task_as_completed
    @task = Task.find(params[:id])
    @task.complete
    render :text => 'Done'
  end
  
  def recently_completed_tasks
    @recently_completed_tasks = current_user.recently_completed_tasks
    render :partial => 'review/recently_completed_tasks_panel'
  end
  
end
