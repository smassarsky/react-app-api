Rails.application.routes.draw do

  post '/login', to: 'session#login'
  post '/signup', to: 'session#signup'
  delete '/logout', to: 'session#logout'
  get '/dashboard', to: 'session#dashboard'

end
