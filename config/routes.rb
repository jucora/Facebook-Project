Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get 'users/index'
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  get 'posts/index'
  get 'posts/edit'
  get 'posts/destroy'
  devise_for :users

  resources :users, only: :index
  resources :comments, only: %i[edit update destroy]
  resources :posts do
    resources :comments
  end
end
