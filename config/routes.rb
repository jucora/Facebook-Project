Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  get 'posts/index'
  get 'posts/edit'
  get 'posts/destroy'
  get 'home/index'
  devise_for :users
	root to: "home#index"

  resources :posts
end
