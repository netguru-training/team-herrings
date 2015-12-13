Rails.application.routes.draw do

  devise_for :users

  get 'admin' => 'admin#dashboard'

  namespace :admin do
    get 'dashboard'
    resources 'users'
    resources :tables
  end

  root to: 'visitors#index'

  resources :dishes

  resources :bookings

  resources :orders
end
