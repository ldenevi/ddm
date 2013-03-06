class HomeController < ApplicationController
  def index
    @user = current_user
    @active_tasks = current_user.active_tasks
    @recently_completed_tasks = current_user.recently_completed_tasks
    @active_reviews = current_user.active_reviews
    @upcoming_reviews = current_user.upcoming_reviews
    @past_due_reviews = current_user.past_due_reviews
  end
end
