GSP::Application.routes.draw do
  constraints :host => /localhost/ do
    devise_for :users, :controllers => { :sessions => :sessions }

    root :to => 'home#index'
  end
end
