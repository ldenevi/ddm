class HomeController < ApplicationController
  def index
    @user = current_user
    @active_tasks = current_user.active_tasks
    @recently_completed_tasks = current_user.recently_completed_tasks
    @active_reviews = current_user.organization.active_reviews
    @upcoming_reviews = current_user.organization.upcoming_reviews
    @past_due_reviews = current_user.organization.past_due_reviews
  end
end
