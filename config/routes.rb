Rails.application.routes.draw do
  root 'front_pages#index'

  get 'front_pages/index'

  resources :users, only: %i(index show new edit update)

  match '/signup', to: 'users#new', via: 'get'
end
