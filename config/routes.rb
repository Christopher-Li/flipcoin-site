Rails.application.routes.draw do
  get '/home', to: 'static_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
