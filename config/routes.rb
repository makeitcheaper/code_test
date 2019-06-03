Rails.application.routes.draw do
  resources :leads, only: [:new, :create] do
    get '/', to: redirect('/leads/new'), on: :collection
  end

  root to: redirect('/leads/new')
end
