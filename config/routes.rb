Rails.application.routes.draw do

  devise_for :users

  get 'admin' => 'admin#dashboard'

  namespace :admin do
    get 'dashboard'
    resources 'users'
    resources :tables
    resources :bookings do
      collection { get :pending }
      member do
        patch :accept
        patch :reject
      end
    end
  end

  root to: 'visitors#index'

  resources :dishes

  resources :orders do
    member do
      post :add_dish
    end
  end
end
