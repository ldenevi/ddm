class HomeController < ApplicationController
  before_filter :check_browser, :only => [:reviews]
  
  def index
    @user = current_user
    @active_tasks = current_user.active_tasks
    @recently_completed_tasks = current_user.recently_completed_tasks
    @active_reviews = current_user.active_reviews
    @upcoming_reviews = current_user.upcoming_reviews
    @past_due_reviews = current_user.past_due_reviews
  end

  # TODO add methods to Task and Review models for these...
  def reviews
    @completed_reviews    = Review.completed(:by_owner, current_user)
    @non_conforming_tasks = Review.non_conforming(:by_owner, current_user).map(&:non_conforming_tasks).flatten
    @past_due_tasks       = Review.past_due(:by_owner, current_user).map(&:past_due_tasks).flatten
    
    # Graphs
    
    # Review Status
    completed  = Review.completed :by_owner, current_user
    in_process = Review.in_process :by_owner, current_user
    past_due   = Review.past_due :by_owner, current_user
    
    # TODO Improve this means of determining when there's no data for the chart to render
    rows = (completed.size + in_process.size + past_due.size == 0) ? [] : [["Completed", completed.size], ["In-Process", in_process.size], ["Past Due", past_due.size]]
    @review_status  = {:id=>"review_status_graph", :title=>"Review Status", :rows=> rows, :colors=>[{"color"=>"#007C43"}, {"color"=>"#00FF8B"}, {"color"=>"#FFF55C"}]}.to_json
    
    # Conforming vs. Non-Conforming
    conforming  = Review.conforming :by_owner, current_user
    non_conforming = Review.non_conforming :by_owner, current_user
    
    rows = (conforming.size + non_conforming.size == 0) ? [] : [["Conforming", conforming.size], ["Non-Conforming", non_conforming.size]]
    @conforming_non_conforming  = {:id=>"conforming_non_conforming_graph", :title=>"Conforming vs. Non-Conforming Reviews", :rows=> rows, :colors=>[{ color: '#007C43' }, { color: '#FF000D' }]}.to_json
    
    # Non-Conforming
    completed_non_conforming  = Review.completed_non_conforming :by_owner, current_user
    in_process_non_conforming = Review.in_process_non_conforming :by_owner, current_user
    
    rows = (completed_non_conforming.size + in_process_non_conforming.size == 0) ? [] : [["Completed", completed_non_conforming.size], ["In-Process", in_process_non_conforming.size]]
    @non_conforming  = {:id=>"non_conforming_graph", :title=>"Non-Conforming Reviews", :rows=> rows, :colors=>[{ color: '#FF000D' }, { color: '#FF5C65' }]}.to_json    
  end
  
  def panel_test
  end
end
