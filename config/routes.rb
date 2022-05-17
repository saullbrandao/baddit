Rails.application.routes.draw do
  devise_for :users
  
  root 'posts#index'
  resources :posts, only: [:new, :create]
  resources :communities, param: :slug, path: 'b' do
    resources :posts, param: :slug, only: [:show] do
      resources :comments, only: [:create]
    end
  end
end
