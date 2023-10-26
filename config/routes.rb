Rails.application.routes.draw do
  resources :sessions
  resources :comments
  resources :tasks
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  mount Securityboat::Base => '/'

  # Defines the root path route ("/")
  root "users#index"
end
