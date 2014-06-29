Rails.application.routes.draw do
  resources :issues do
    member do
      post :upvote
      post :downvote
    end
  end

  root :to => 'issues#index'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }
  resources :users
end
