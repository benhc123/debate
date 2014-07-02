Rails.application.routes.draw do
  resources :theses

  resources :issues do
    member do
      post :upvote
      post :downvote
      post :voteyea
      post :votenay
    end
  end

  root :to => 'issues#index'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }
  resources :users
end
