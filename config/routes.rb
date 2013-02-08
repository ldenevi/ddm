GSP::Application.routes.draw do
  constraints :host => /localhost/ do
    devise_for :users

    root :to => 'home#index'
  end
end
