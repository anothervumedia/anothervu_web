Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'pages#feed', as: 'feed'
  get 'sort_new', to: 'pages#sort_new', as: 'sort_new'
  get 'liked', to: 'pages#liked', as: 'liked'

  get 'terms', to: 'pages#terms', as: 'terms'
  get 'about', to: 'pages#about', as: 'about'
  get 'privacy', to: 'pages#privacy', as: 'privacy'
  get 'contact', to: 'pages#contact', as: 'contact'


  resources :projects, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :uploads, only: [:new, :create, :destroy]
    resources :comments
  end

  resources :conversations do
    resources :messages
  end
  resources :hearts, only: [:create, :destroy]
  resources :users, only: [:show, :edit, :update]
end
