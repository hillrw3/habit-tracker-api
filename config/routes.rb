Rails.application.routes.draw do
  resources :logins, only: [:create]
end
