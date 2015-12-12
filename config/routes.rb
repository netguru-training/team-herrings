Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  resources :dishes

  resource :bookings
end
