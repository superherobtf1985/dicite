Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :end_user do
    resources :users, only: [:show, :update] do
      member do
        get :unsubscribe
        post :unsubscribe
        get "unsubscribe/complete" => "users#complete"
      end
    end
    resources :contacts, only: [:new, :create]
    resources :items, only: [:index, :show] do
      member do
        resource :favorites, only: [:create, :destroy]
        resource :reviews, only: [:create, :destroy]
      end
    end
    resources :carts, only: [:show, :create]
    resources :payments, only: [:new, :create] do
      get "confirm", on: :member
      get "complete", on: :collection
    end
  end

  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :contacts, only: [:index, :show, :update]
    resources :orders, only: [:index, :show, :update]
    resources :items, only: [:index, :create, :show, :update, :destroy, :new] do
      resources :reviews, only: [:update, :destroy]
    end
  end

end
