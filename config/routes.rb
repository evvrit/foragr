Rails.application.routes.draw do
  devise_for :users
  root to: "caches#index"

  resources :caches, only: :index, as: :caches
  resources :caches, only: :show, as: :cache
  resources :species, only: %i[show]
  resources :logs
end
