Rails.application.routes.draw do
  devise_for :users
  
  root 'posts#index'

  resources :posts, only: [:new, :create, :destroy] do
    patch 'upvote'
    patch 'downvote'
  end

  resources :comments, only: [:destroy] do
    patch 'upvote'
    patch 'downvote'
  end

  resources :communities, param: :slug, path: 'b' do
    post 'join'
    delete 'leave'
  
    resources :posts, param: :slug, only: [:show] do
      resources :comments, only: [:create]
    end
  end
end
