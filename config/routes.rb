Rails.application.routes.draw do
  devise_for :users
  root to: "caches#index"

  resources :cache, only: %i[index]
  resources :species, only: %i[show]
end
