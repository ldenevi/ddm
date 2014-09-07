GSP::Application.routes.draw do

  namespace :trial do
    get  "sign_up/index"
    post "sign_up/new_password"

    get "sign_up/form"
    post "sign_up/register_new_user", :as => "register_new_user"
    get "sign_up/already_registered"
    get "sign_up/welcome"
    get "sign_up/setup_organizations"
    get "sign_up/setup_users"

    get "organization/new"
    post "organization/create", :as => "create_new_organization"
  end

  namespace :cfsi do
    get "cmrt/index"
    get "cmrt/show/:id", :to => "cmrt#show"
    post "cmrt/new"
    post "cmrt/validate/:batch_id", :to => "cmrt#validate"
    post "cmrt/validate_zip/:batch_id", :to => "cmrt#validate_zip"
    get "cmrt/list_validation_statuses/:batch_id", :to => "cmrt#list_validation_statuses"
    get "cmrt/download/:id", :to => "cmrt#download"

    get "reports/aggregated_declarations/:batch_id", :to => "reports#aggregated_declarations"
    get "reports/consolidated_smelters/:batch_id", :to => "reports#consolidated_smelters"

    get "compliant_smelters/list"
    post "compliant_smelters/update"

    get "smelters_reference/list"
    post "smelters_reference/update"
  end
  
  namespace :roadmap do
    get "reports/comprehensive_due_diligence/:review_id", :to => "reports#comprehensive_due_diligence", :as => "comprehensive_report"
  end

  get "reviews/list"

  get "reviews/show"

  get "calendar/show"

  get "reports/list"

  get "reports/view"

  get "help/initial_usage"

  get "templates/list"

  # Home
  #root :to => 'home#index'
  root :to => 'home#reviews'
  get "reviews", :to => 'home#reviews', :as => 'home_reviews'
  get "index", :to => 'home#index', :as => 'home'
  get "test", :to => 'home#panel_test'

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

    # New 'Standard' model
    get "template/show_readonly/:id", :to => 'templates#show_readonly'
    get "admin/gsp_templates/show_readonly/:id", :to => "admin/gsp_templates#show_readonly"
    put "template/update/:id", :to => 'templates#update', :as => 'update_organization_template'
    put "admin/gsp_templates/update/:id", :to => 'admin/gsp_templates#update', :as => 'update_gsp_template'


  # Organization Templates
  get "template/list", :to => 'templates#list'
  get "template/show/:id", :to => 'templates#show', :as => 'template_show'
  post "template/deploy_review", :to => 'templates#deploy_review', :as => 'deploy_review'
  get "template/:id/prepare_review", :to => "templates#prepare_review", :as => 'prepare_review'
  get "template/settings/:id", :to => "templates#settings", :as => 'template_settings'
  put "template/set_recurrence/:id", :to => "templates#set_recurrence", :as => "template_set_recurrence"
  get "template/new", :to => "templates#new_organization_template", :as => 'new_organization_template'
  post "template/create", :to => "templates#create"
  get "template/send_ical/:id", :to => "templates#send_ical", :as => 'send_ical'

  # GSP Templates
  get "admin/gsp_templates/index", :to => "admin/gsp_templates#index", :as => 'admin_templates'
  get "admin/gsp_templates/list", :to => "admin/gsp_templates#list", :as => 'admin_list_templates'
  get "admin/gsp_templates/new", :to => "admin/gsp_templates#new", :as => 'admin_new_template'
  post "admin/gsp_templates/create", :to => "admin/gsp_templates#create"
  get "admin/gsp_templates/show/(:id)", :to => "admin/gsp_templates#show", :as => "admin_template_show"

  # Review
  get "review/show/:id", :to => "review#show", :as => "show_review"
  get "review/list", :to => "review#list", :as => "list_reviews"
  get "review/task_list/:id", :to => "review#task_list", :as => "list_tasks"

  get "review/task/:id/show", :to => "review#show_task", :as => "task_show"
  get "tasks/active", :to => "review#active_tasks", :as => "active_tasks"
  post "tasks/mark_completed/:id(/:status)", :to => "review#mark_task_as_completed", :as => 'mark_task_completed'
  post "tasks/reopen/:id", :to => "review#reopen_task", :as => 'reopen_task'
  get "tasks/recently_completed_tasks", :to => "review#recently_completed_tasks", :as => 'recently_completed_tasks'

  post "review/task/:id/comment/post", :to => "review#post_comment", :as => "post_comment"
  get  "review/task/comment/:id/show", :to => "review#show_comment", :as => "show_comment"
  get  "review/task/:task_id/comment/form", :to => "review#post_comment_form", :as => "post_comment_form"

  get "review/get_file/:id", :to => "review#get_attachment", :as => "get_file"

  # Calendar
  get "calendar/datafeed/:method", :to => "calendar#datafeed"
  post "calendar/datafeed/:method", :to => "calendar#datafeed"

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
