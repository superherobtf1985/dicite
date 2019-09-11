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
    resources :carts, only: [:create, :destroy, :update]
    resource :carts, only: [:show]
    resource :payments, only: [:new, :create] do
      post "confirm", on: :member
      post "complete", on: :collection
      post "create_shipping", on: :member
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :update, :destroy]
    resources :contacts, only: [:index, :show, :update]
    resources :orders, only: [:index, :show, :update]
    resources :items, only: [:index, :create, :show, :update, :destroy, :new] do
      resources :reviews, only: [:update, :destroy]
    end
    post "/items/artist", to: "items#make_artist", as: "make_artist"
    post "/items/label", to: "items#make_label", as: "make_label"
    post "/items/genre", to: "items#make_genre", as: "make_genre"
  end

  root 'end_user/items#index'

  constraints -> request { request.session[:admin_id].present? } do
    root 'admin/items#index'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
