Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :end_user do
    #   後で下を追加
    #devise_for :users
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
    #   後で下を追加
    #devise_for :users
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :contacts, only: [:index, :show, :update]
    resources :items, only: [:index, :create, :edit, :update, :destroy] do
      resources :reviews, only: [:update, :destroy]
    end
  end

end
