Rails.application.routes.draw do
  resources :leaderboards, only: [:index]
  resources :matches
  resources :players
  root 'leaderboards#index'
end