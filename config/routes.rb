Rails.application.routes.draw do
  resources :posts
  root "posts#index"
  get '/account', to: 'account#show'
  get '/reservations/confirm', to: 'reservations#index'
  resources :reservations
  resources :rooms do
    collection do
      get 'search', to: 'rooms#search'
    end
  end
  devise_for :users
  resources :rooms
  get 'accounts/show'
  resources :users
  resource :account, only: [:edit, :update, :show]
  get '/account', to: 'accounts#show'
  get '/users', to: 'users#show'
  get '/rooms', to: 'rooms#new'
  post '/rooms', to: 'rooms#update'
  get '/reservations/confirm', to: 'reservations#confirm', as: 'confirm_reservation'
  post '/reservations/confirm', to: 'reservations#confirm'
  get '/rooms/search', to: 'rooms#search'

  resources :reservations, only: [:index, :new, :create, :show] do
    collection do
      post 'confirm'
    end
  end
end


