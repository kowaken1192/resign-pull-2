Rails.application.routes.draw do
  get '/account', to: 'account#show'
  resources :reservations
  resources :rooms do
    collection do
      get 'search', to: 'rooms#search'
    end
  end
  resources :reservations
  devise_for :users
  resources :rooms
  get 'accounts/show'
  resources :posts
  root "posts#index"
  resources :users
  resource :account, only: [:edit, :update, :show]
  get '/account', to: 'accounts#show'
  get '/users', to: 'users#show'
  get '/rooms', to: 'rooms#new'
  post '/rooms', to: 'rooms#update'
  get '/reservations/confirm', to: 'reservations#confirm', as: 'confirm_reservation'
  post '/reservations/confirm', to: 'reservations#confirm'
  get '/reservations/confirm', to: 'reservations#index'
  get '/rooms/search', to: 'rooms#search'

  resources :reservations, only: [:index, :new, :create, :show] do
    collection do
      post 'confirm'
    end
  end
end

