Rails.application.routes.draw do
  resources :leads, only: %i[new create]

  root to: 'leads#new'
end
