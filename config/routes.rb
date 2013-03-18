GSP::Application.routes.draw do
  get "help/initial_usage"

  get "templates/list"

  root :to => 'home#index'
  
  devise_for :users, :controllers => { :sessions => :sessions }
  
  # GSP Template Manager javascript
  put "organization_templates/:id/update_attributes", :to => "templates#ot_update_attributes"
  put "organization_templates/:id/update_task/:task_sequence", :to => "templates#ot_update_task"
  put "gsp_templates/:id/update_attributes", :to => "templates#gspt_update_attributes"
  put "gsp_templates/:id/update_task/:task_sequence", :to => "templates#gspt_update_task"
  put "review_templates/:id/update_attributes", :to => "templates#review_update_attributes"
  
  # Template editing
  get "templates/temp_show(/:t_id(/:ot_id))", :to => 'templates#temporary_template_display'
  get "organization_template/:ot_id/new_task", :to => 'templates#new_task'
  get "gsp_template/:t_id/new_task", :to => 'templates#new_task'
  delete "organization_template/:ot_id/:task_sequence/destroy_task", :to => 'templates#destroy_task'
  delete "gsp_template/:t_id/:task_sequence/destroy_task", :to => 'templates#destroy_task'
  get "templates/field_options/:field_name", :to => 'templates#field_options'
  
  
  # Organization Templates
  get "template/list", :to => 'templates#list'
  get "template/show/:id", :to => 'templates#show', :as => 'template_show'
  post "template/deploy_review", :to => 'templates#deploy_review', :as => 'deploy_review'
  get "template/:id/prepare_review", :to => "templates#prepare_review", :as => 'prepare_review'
  get "template/new", :to => "templates#new_organization_template", :as => 'new_organization_template'
  
  # GSP Templates
  get "admin/gsp_templates/index", :to => "admin/gsp_templates#index", :as => 'admin_templates'
  get "admin/gsp_templates/list", :to => "admin/gsp_templates#list", :as => 'admin_list_templates'
  get "admin/gsp_templates/new", :to => "admin/gsp_templates#new", :as => 'admin_new_template'
  post "admin/gsp_templates/create", :to => "admin/gsp_templates#create"
  get "admin/gsp_templates/show/(:id)", :to => "admin/gsp_templates#show", :as => "admin_template_show"
  
  # Review
  get "review/task/:id/show", :to => "review#show_task", :as => "task_show"
  get "tasks/active", :to => "review#active_tasks", :as => "active_tasks"
  post "tasks/mark_completed/:id", :to => "review#mark_task_as_completed", :as => 'task_mark_completed'
  get "tasks/recently_completed_tasks", :to => "review#recently_completed_tasks", :as => 'recently_completed_tasks'
  
  post "review/task/:id/comment/post", :to => "review#post_comment", :as => "post_comment"
  get  "review/task/comment/:id/show", :to => "review#show_comment", :as => "show_comment"
  get  "review/task/:task_id/comment/form", :to => "review#post_comment_form", :as => "post_comment_form"
  
  
  # Reports
  
  # Store
  
  
  # Organization
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
