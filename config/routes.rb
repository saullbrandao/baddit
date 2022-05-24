Rails.application.routes.draw do
  devise_for :users
  
  root 'posts#index'

  resources :posts, only: [:new, :create] do
    post 'upvote'
    post 'downvote'
  end

  resources :comments, only: [:destroy] do
    post 'upvote'
    post 'downvote'
  end

  resources :communities, param: :slug, path: 'b' do
    post 'join'
    delete 'leave'
  
    resources :posts, param: :slug, only: [:show, :destroy] do
      resources :comments, only: [:create]
    end
  end
end
