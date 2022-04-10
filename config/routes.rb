# frozen_string_literal: true

Rails.application.routes.draw do
  resources :chatroom_users, only: %i[create destroy]
  resources :chatrooms, only: %i[create destroy show index]
  resources :messages, only: %i[create destroy]
  resources :comments, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :posts
  devise_for :users
  get '/profile/:id', to: 'users#show', as: 'profile'
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
