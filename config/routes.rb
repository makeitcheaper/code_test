Rails.application.routes.draw do
  get '/', to: redirect('create')
  get 'create', to: 'create#show'
end
