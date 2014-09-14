Rails.application.routes.draw do
  root 'front_pages#index'

  get 'front_pages/index'

  resources :users, only: %i(index show new create edit update)

  resources :sessions, only: %i(new create destroy)
  match '/signup', to: 'users#new',        via: 'get'
  match '/login',  to: 'sessions#new',     via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
end
