# frozen_string_literal: true

Rails.application.routes.draw do
  get 'chatroom_users/create'
  get 'chatroom_users/destroy'
  resources :chatrooms do
    resources :messages
  end
  resources :comments, only: %i[create destroy]
  resources :chatroom_users
  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :posts
  devise_for :users
  get '/profile/:id', to: 'users#show', as: 'profile'
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
