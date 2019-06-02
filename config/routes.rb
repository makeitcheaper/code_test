Rails.application.routes.draw do
  resources :leads, only: [:new, :create]

  root to: redirect('/leads/new')
end
