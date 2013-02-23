GSP::Application.routes.draw do
  get "help/initial_usage"

  get "templates/list"

  root :to => 'home#index'
  
  devise_for :users, :controllers => { :sessions => :sessions }
  
  # Templates
  get "template/list", :to => 'templates#list'
  get "template/show/:id", :to => 'templates#show', :as => 'template_show'
  post "template/:id/deploy_review", :to => 'templates#deploy_review', :as => 'deploy_review'

  # Review
  get "review/task/:id/show/", :to => "review#show_task", :as => "task_show"
  get "tasks/active", :to => "review#active_tasks", :as => "active_tasks"
  post "tasks/mark_completed/:id", :to => "review#mark_task_as_completed", :as => 'task_mark_completed'
  get "tasks/recently_completed_tasks", :to => "review#recently_completed_tasks", :as => 'recently_completed_tasks'
  
  # Organization
  
  # Reports
  
  # Store
  
  
  get "organization/index", :to => 'organization#index'
  get "organization/hierarchy", :to => 'organization#hierarchy', :as => 'organization_hierarchy'
  get "organization/overview",  :to => 'organization#overview',  :as => 'organization_overview'
  get "organization/templates",  :to => 'organization#templates',  :as => 'organization_templates'

  # Review
  get "organization/deployable_list",  :to => 'organization#deploy_reviews',  :as => 'deployable_list'
  get "organization/generate_review/:purchased_template_id",  :to => 'organization#generate_review',  :as => 'generate_review'
  put "organization/update_review/:review_id", :to => 'organization#update_review'
  get "organization/deployed_reviews", :to => 'organization#deployed_reviews', :as => 'deployed_reviews'
  
  post "organization/share_template/:purchased_template_id", :to => 'organization#share_template', :as => 'share_template'
end
