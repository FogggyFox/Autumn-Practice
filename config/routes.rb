# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'users#show'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/admin/sidekiq'

  get '/users', to: 'users#index'
  resources :users do
    member do
      patch 'send_money'
      patch 'transfer_orders'
    end
  end
  resources :orders do
    member do
      post 'change'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount AddressApi::Api => '/'
  resources :docs, only: :index
end
