Rails.application.routes.draw do
  resource :login, only: [:create]
  resources :habits, only: [:index]
  resources :users, only: [:create]
end
