# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#index'

  get '/admin', to: 'admin/users#home', as: :admin_root

  namespace 'admin' do
    get '/requests', to: 'requests#show', as: :requests
    get 'approve/:id/request/:sender_id/to/:receiver_id', to: "requests#approve", as: :approve_request

    resources :users do
      member do
        get 'request/:other_user_id', to: 'requests#create', as: :get_request
      end
    end
  end

  resources :users do
    member do
      get 'chat_with/:other_user_id', to: 'conversations#show', as: :chat_with

    end
  end

  resources :conversations, only: [:show] do
    resources :messages, only: [:create]
  end

  get "/login", to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/seller', to: 'users#become_seller'
end
