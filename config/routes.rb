Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get 'users/index'
  get 'users/show'
  get 'users/friends', to: 'users#friends'
  get 'users/friends_pending', to: 'users#friends_pending'
  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  get 'posts/index'
  get 'posts/edit'
  get 'posts/destroy'
  put 'friendships/:id', to: 'friendships#update'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: %i[index show]
  resources :comments, only: %i[edit update destroy]
  resources :friendships, only: %i[create update destroy]
  resources :posts do
    resources :comments
    resources :likes
  end

end
