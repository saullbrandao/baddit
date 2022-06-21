Rails.application.routes.draw do
  devise_for :users
  
  root "posts#index"

  resources :posts, except: [:index, :show] do
    collection do
      post :paginate
    end
    patch 'upvote'
    patch 'downvote'
    resources :comments, only: [:create]
  end

  resources :comments, only: [:edit, :update, :destroy] do
    patch 'upvote'
    patch 'downvote'
  end

  resources :communities, param: :slug, path: 'b', except: [:index] do
    post :paginate
    post 'join'
    delete 'leave'
    resources :posts, param: :slug, only: [:show]
  end
end
