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
    resources :tables
    resources :users
  end

  resources :bookings, only: [:create, :index, :new, :show]
  resources :categories
  resources :dishes, only: [:index, :show]

  resources :orders do
    member { post :add_dish }
  end

  get '/menu', to: 'menu#index'
end
