Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'feed', to: 'pages#feed', as: 'feed'

  resources :uploads, only: [:new, :create]
  resources :hearts, only: [:create, :destroy]
end
