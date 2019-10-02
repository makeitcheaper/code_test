Rails.application.routes.draw do
  mount API => '/'

  get '*path', to: 'pages#index'

  root to: 'pages#index'
end
