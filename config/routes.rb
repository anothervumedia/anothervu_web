Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'feed', to: 'pages#feed', as: 'feed'

  resources :projects, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :hearts, only: [:create, :destroy]
end
