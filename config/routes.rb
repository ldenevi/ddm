GSP::Application.routes.draw do
  root :to => 'home#index'
  
  devise_for :users, :controllers => { :sessions => :sessions }

  get "organization/index", :to => 'organization#index'
  get "organization/hierarchy", :to => 'organization#hierarchy', :as => 'organization_hierarchy'
  get "organization/overview",  :to => 'organization#overview',  :as => 'organization_overview'
end
