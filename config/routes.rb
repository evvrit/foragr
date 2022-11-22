Rails.application.routes.draw do
  get 'logs/new'
  get 'logs/create'
  get 'logs/update'
  get 'logs/edit'
  get 'logs/destroy'
  get 'logs/index'
  get 'logs/show'
  devise_for :users
  root to: "caches#index"

  resources :caches, only: :index, as: :caches
  resources :caches, only: :show, as: :cache
  resources :species, only: %i[show]
  resources :logs
end
