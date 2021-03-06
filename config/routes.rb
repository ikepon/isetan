Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'front_pages#index'

  get 'front_pages/index'

  resources :users, only: %i(index show new create edit update)

  namespace :mypage do
    root to: 'profile#edit'
    resources :profile, only: %i(edit update), controller: :profile

    resources :books, only: %i(create)

    match 'collections/new', via: 'post'
    resources :collections, only: %i(index show new create edit) do
      collection do
        post :confirm
      end

      member do
        patch :rend
        patch :return
      end
    end

    resources :lends, only: %i(index)

    resources :reviews, only: %i(index show new create edit update)
  end

  resources :news, only: %i(index show)

  resources :books, only: %i(index show)

  resources :reviews, only: %i(index show)

  resources :lends, only: %i(index show)

  resources :contacts, only: %i(new create) do
    collection do
      post :confirm
      get :complete
    end
  end

  resources :sessions, only: %i(new create destroy)
  match '/signup', to: 'users#new',        via: 'get'
  match '/login',  to: 'sessions#new',     via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
end
