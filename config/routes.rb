Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#index'
  get "/", to: "application#index"

  get "/login", to: "sessions#new"
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :merchants
  # get "/merchants", to: "merchants#index"
  # get "/merchants/new", to: "merchants#new"
  # get "/merchants/:id", to: "merchants#show"
  # post "/merchants", to: "merchants#create"
  # get "/merchants/:id/edit", to: "merchants#edit"
  # patch "/merchants/:id", to: "merchants#update"
  # delete "/merchants/:id", to: "merchants#destroy"

  namespace :merchant do
    get '/', to: 'dashboard#show'
    get '/items', to: 'dashboard#index'
  end

  resources :items
  # get "/items", to: "items#index"
  # get "/items/:id", to: "items#show"
  # get "/items/:id/edit", to: "items#edit"
  # patch "/items/:id", to: "items#update"
  # delete "/items/:id", to: "items#destroy"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  resources :reviews
  # get "/reviews/:id/edit", to: "reviews#edit"
  # patch "/reviews/:id", to: "reviews#update"
  # delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id", to: "cart#update"
  patch "/cart/:item_id/decrease", to: "cart#decrease"

  resources :orders
  # get "/orders/new", to: "orders#new"
  # post "/orders", to: "orders#create"
  # get "/orders", to: "orders#index"
  # get "/orders/:id", to: "orders#show"
  # delete "/orders/:id", to: "orders#destroy"

  get "/profile", to: "users#show"
  get "/profile/edit", to: "users#edit"
  patch "/profile/edit", to: "users#update"
  patch "/profile/edit_password", to: "users#update_password"
  get '/profile/edit_password', to: "users#edit_password"

  get "/register", to: "users#new"
  post '/users', to: 'users#create'

  namespace :admin do
    get '/', to: 'dashboard#show'
    get '/users', to: 'dashboard#index'
    resources :merchant, only: [:index, :update, :show]
    # get '/merchants', to: 'merchant#index'
    # patch '/merchant/:merchant_id', to: 'merchant#update'
    # get '/merchants/:merchant_id', to: 'merchant#show'
  end
end
