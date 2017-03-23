Rails.application.routes.draw do
  root   'static_pages#home'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/allow', to: 'users#allow'
  post '/remove', to: 'users#remove'
  post '/delete', to: 'jobs#delete'
  resources :users
  resources :jobs
end