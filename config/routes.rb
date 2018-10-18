Rails.application.routes.draw do
  resources :leads, only: [:new, :create] do
    get 'thank_you', on: :collection
  end


  root to: 'leads#new'
end
