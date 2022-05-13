Rails.application.routes.draw do
  devise_for :users
  
  root 'posts#index'
  resources :communities, param: :slug, path: 'b' do
    resources :posts, param: :slug
  end
end
