Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'subjects#index'

  resources :classes, controller: :subjects, as: :subjects, only: [] do
    resources :professors, only: :index
  end

  resources :reviews, only: [:create, :update, :destroy]
end
