Rails.application.routes.draw do
  resources :callback_requests, only: [:create, :new]
end
