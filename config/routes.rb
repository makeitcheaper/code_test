Rails.application.routes.draw do
  get 'leads/new' => 'leads#new'
  post '/leads/create' => "leads#create"
  get '/leads/success' => 'leads#success'
end
