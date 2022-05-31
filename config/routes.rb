Rails.application.routes.draw do
  devise_for :users
  
  root 'posts#index'

  resources :posts, only: [:new, :create, :update, :edit, :destroy] do
    patch 'upvote'
    patch 'downvote'
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy] do
    patch 'upvote'
    patch 'downvote'
  end

  resources :communities, param: :slug, path: 'b' do
    post 'join'
    delete 'leave'
    resources :posts, param: :slug, only: [:show]
  end
end
