Rails.application.routes.draw do
  resources :users

  post 'busca', to: 'users#search', as: 'search_users'
  get 'activate', to: 'users#activate', as: 'activate_users'
  get 'sessions', to: 'sessions#new', as: :sessions
  post 'sessions', to: 'sessions#create'
  delete 'sessions', to: 'sessions#destroy', as: 'destroy_sessions'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
