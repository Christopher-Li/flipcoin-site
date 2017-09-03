Rails.application.routes.draw do
  # temporary
  get '/users/:id/edit', to: 'static_pages#404'
  # get '/faq', to: 'static_pages#faq'
  
  get '/signup', to: 'users#usertypes'
  get '/signup/individual', to: 'users#newindividual'
  post '/signup/individual', to: 'users#createindividual'
  get '/signup/entity', to: 'users#newentity'
  post '/signup/entity', to: 'users#createentity'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "/logout", to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
