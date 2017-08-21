Rails.application.routes.draw do
  get '/faq', to: 'static_pages#faq'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  namespace :admin do
    get 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'
  end
end