Rails.application.routes.draw do
  devise_for :users
  
  root 'posts#index'
  resources :posts, only: [:new, :create]
  resources :comments, only: [:destroy]
  resources :communities, param: :slug, path: 'b' do
    resources :posts, param: :slug, only: [:show, :destroy] do
      resources :comments, only: [:create]
    end
  end
end
