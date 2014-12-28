Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'front_pages#index'

  get 'front_pages/index'

  resources :users, only: %i(index show new create edit update)
  resources :news, only: %i(index show new create)
  resources :books
  resources :collections
  resources :reviews

  resources :sessions, only: %i(new create destroy)
  match '/signup', to: 'users#new',        via: 'get'
  match '/login',  to: 'sessions#new',     via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
end
