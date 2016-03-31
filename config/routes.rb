Rails.application.routes.draw do
  root to: "homes#show"

  resources :stores, only: [:index, :new, :create, :update, :destroy]
  resources :items, only: [:index]

  resources :cart_items, only: [:create, :destroy]
  get "/cart", to: "cart_items#index"

  resource :user, only: [:create, :new, :edit, :update]
  resources :orders, only: [:index, :create, :show, :update]

  get "/dashboard", to: "users#show", as: "dashboard"

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :orders, only: [:show, :index]
    get "/:status", to: "orders#index", as: "status"
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :weather, only: [:create, :show, :new]
  get "/homes", to: "homes#index"

  resources :categories, only: [:index, :new, :create]

  get "/categories/:slug", to: "categories#show", as: "category"
  get "/categories/:slug/edit", to: "categories#edit", as: "edit_category"
  put "/categories/:slug", to: "categories#update", as: "update_category"
  delete "/categories/:slug", to: "categories#destroy", as: "delete_category"

  get "/:slug/edit", to: "stores#edit", as: "edit_store"

  namespace :stores, path: ":slug", as: :store do
    get "", to: "items#index", as: "root"
    resources :items, only: [:show, :new, :destroy, :edit, :create, :update]
  end
end
