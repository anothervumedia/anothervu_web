Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'pages#home', as: 'home'
  get 'feed', to: 'pages#feed', as: 'feed'
  get 'terms', to: 'pages#terms', as: 'terms'
  get 'about', to: 'pages#about', as: 'about'
  get 'privacy', to: 'pages#privacy', as: 'privacy'
  get 'contact', to: 'pages#contact', as: 'contact'


  resources :projects, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :uploads, only: [:new, :create, :destroy]
  end
  resources :hearts, only: [:create, :destroy]
  resources :users, only: [:show, :edit, :update]
end
