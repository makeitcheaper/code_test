Rails.application.routes.draw do
  root 'pages#index'
  resources 'leads'
end
