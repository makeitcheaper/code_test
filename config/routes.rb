Rails.application.routes.draw do
  resources :leads, only: [:new, :create] do
    collection do
      get :thankyou
    end
  end
  
  root to: 'leads#new'
end
