Rails.application.routes.draw do
  resource :leads

  root to: 'leads#show'
end
