GSP::Application.routes.draw do
  root :to => 'home#index'
  
  devise_for :users, :controllers => { :sessions => :sessions }

  get "organization/index", :to => 'organization#index'
  get "organization/hierarchy", :to => 'organization#hierarchy', :as => 'organization_hierarchy'
  get "organization/overview",  :to => 'organization#overview',  :as => 'organization_overview'
  get "organization/templates",  :to => 'organization#templates',  :as => 'organization_templates'

  # Review
  get "organization/deployable_list",  :to => 'organization#deploy_reviews',  :as => 'deployable_list'
  get "organization/generate_review/:purchased_template_id",  :to => 'organization#generate_review',  :as => 'generate_review'
  put "organization/update_review/:review_id", :to => 'organization#update_review'
  post "organization/deploy_review", :to => 'organization#deploy_review', :as => 'deploy_review'
  
end
