Rails.application.routes.draw do

  post '/login', to: 'session#login'
  post '/signup', to: 'session#signup'
  delete '/logout', to: 'session#logout'
  get '/dashboard', to: 'session#dashboard'

  resources :teams, only: [:index, :show, :create, :update, :destroy]

  resources :players, only: [:show, :create, :update, :destroy]

  resources :seasons, only: [:index, :show, :create, :update, :destroy]

  resources :games, only: [:index, :show, :create, :update, :destroy]

  post '/add-player', to: 'games#add_player'
  delete '/remove-player', to: 'games#remove_player'

  resources :goals, only: [:create, :update, :destroy]

  resources :penalties, only: [:create, :update, :destroy]

end
