Rails.application.routes.draw do
  get 'contact-us', to: 'leads#new', as: 'new_lead'
  post 'contact-us', to: 'leads#create', as: 'create_lead'
end
