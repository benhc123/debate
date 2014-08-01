Rails.application.routes.draw do
  resources :organizations

  resources :issues do
    member do
      post :upvote
      post :downvote
      post :voteyea
      post :votenay
      patch :revert
    end
    resources :theses, except: [:index] do
      member do
        patch :revert
      end
    end
  end

  root :to => 'issues#index'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :users do
    member do
      get :delegate
    end
  end
end
