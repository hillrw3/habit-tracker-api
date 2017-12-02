Rails.application.routes.draw do
  resource :login, only: [:create]
  resources :habits, only: [:index, :create]
  put '/habits/:id/perform' => 'habits#perform'
  resources :users, only: [:create]
end
