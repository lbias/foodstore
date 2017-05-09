Rails.application.routes.draw do
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash

    end
  end
  resources :carts do
    collection do
      delete :clean
      get :checkout
    end
  end
  namespace :account do
    resources :orders
  end
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end
  resources :cart_items do
    member do
      post :add_quantity
      post :remove_quantity
    end
  end
  resources :users, only: [:index]
  resources :messages, only: [:new, :create]
  resources :categories
  resources :products do
    put :favorite, on: :member
    resources :favorite do
      end
    member do
      post :add_to_cart
      post :upvote
      post :add_buying_quantity
      post :remove_buying_quantity
    end
    collection do
      get :search
    end
    resources :posts
  end
   devise_for :user, controllers: {
     passwords: 'users/passwords',
     registrations: 'users/registrations',
     sessions: 'users/sessions'
   }
  root 'welcome#index'

  namespace :admin do
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
