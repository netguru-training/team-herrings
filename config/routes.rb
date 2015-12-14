Rails.application.routes.draw do
  devise_for :users

  root to: 'visitors#index'

  get 'admin' => 'admin#dashboard'

  namespace :admin do
    get 'dashboard'

    resources :bookings do
      collection { get :pending }
      member do
        patch :accept
        patch :reject
      end
    end
    resources :dishes
    resources :tables
    resources :users
  end

  resources :bookings, only: [:create, :index, :new, :show]
  resources :dishes, only: :index

  resources :orders do
    member { post :add_dish }
  end
end
