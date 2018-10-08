Rails.application.routes.draw do
  root 'leads#new'
  resources 'leads'
end
