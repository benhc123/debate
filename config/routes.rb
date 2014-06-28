Rails.application.routes.draw do
  resources :issues

  root :to => "visitors#index"
  devise_for :users
  resources :users
end
