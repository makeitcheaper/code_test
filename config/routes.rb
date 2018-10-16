Rails.application.routes.draw do
  resources :leads, only: [:new, :create]
end
