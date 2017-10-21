Rails.application.routes.draw do
  resources :logins, only: [:create]
  post '/login', to: 'logins#create'
end
