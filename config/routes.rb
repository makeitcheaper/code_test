Rails.application.routes.draw do
  root 'callback#index'
  get '/callback', to: redirect('/'), as: 'callback'
  post '/callback', to: 'callback#create'
end
