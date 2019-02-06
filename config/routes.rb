Rails.application.routes.draw do
  root to: 'leads#new'
  resources :leads, only: %i[new create]
end
