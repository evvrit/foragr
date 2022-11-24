Rails.application.routes.draw do
  get 'logs/css_test', to: 'logs#css_test', as: :css_test

  devise_for :users
  root to: "caches#index"

  resources :caches, only: :index do
    member do
      post 'toggle_favorite', to: "caches#toggle_favorite"
    end
  end

  resources :caches, only: :new, as: :cache
  resources :caches, only: :create

  resources :caches, only: :show, as: :cache

  resources :species, only: %i[show]
  resources :logs
end
