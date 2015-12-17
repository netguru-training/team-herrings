Rails.application.routes.draw do
  devise_for :users

  root to: 'visitors#index'

  get 'admin' => 'admin#dashboard'

  namespace :admin do
    get 'dashboard'

    resources :bookings do
      member do
        get :rejection
        patch :accept
        patch :reject
      end
    end
    resources :dishes
    resources :categories
    resources :tables
    resources :users
  end

  resources :bookings, only: [:create, :index, :new, :show]
  resources :dishes, only: :index

  resources :orders do
    member { post :add_dish }
  end
end
