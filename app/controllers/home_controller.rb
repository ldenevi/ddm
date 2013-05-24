class HomeController < ApplicationController
  def index
    @user = current_user
    @active_tasks = current_user.active_tasks
    @recently_completed_tasks = current_user.recently_completed_tasks
    @active_reviews = current_user.active_reviews
    @upcoming_reviews = current_user.upcoming_reviews
    @past_due_reviews = current_user.past_due_reviews
    
    # Charts
    @graph_image_url = Gchart.pie(:size => '200x200', 
                                  :title => "Reviews Status",
                                  :bg => 'dddddd',
                                  :legend => ['Completed', 'In-Progress'],
                                  :data => [0, @active_reviews.size])
                                  
   @task_graph = Gchart.pie(:size => '200x200', 
                            :title => "Task Status",
                            :bg => 'dddddd',
                            :legend => ['Completed', 'Open', 'Past Due'],
                            :data => [@recently_completed_tasks.size, @active_tasks.size, 0])
                            
   @task_finding_graph = Gchart.pie(:size => '200x200', 
                                    :title => "Task Findings",
                                    :bg => 'dddddd',
                                    :legend => ['Conformance', 'Non-Conformance', "In-Process"],
                                    :data => [0, 0, @active_tasks.size])
  end

  # TODO add methods to Task and Review models for these...
  def reviews
    @active_reviews       = current_user.active_reviews
    @non_conforming_tasks = Task.limit(3)
    @past_due_tasks       = Task.limit(5)
  end
end
