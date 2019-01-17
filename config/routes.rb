Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    match "/auth/:provider/callback", to: "sessions#create",via: [:get, :post]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'items/search', to: 'items#search'
  get 'items/search_material', to: 'items#get_search_material'
  get 'mypage' => 'users#mypage'
  get 'mypage/profile' => 'users#profile'
  get 'mypage/identification', to: 'users#identification'
  get 'mypage/favorite', to: 'users#favorite'
  get 'mypage/purchace', to: 'users#purchace'
  get 'mypage/purchaced', to: 'users#purchaced'
  get 'users/signup', to: 'users#signup'
  get 'users/logout', to: 'users#logout'
  get 'users/registration_card' => 'users#registration_card'
  resources :items, only: [:new, :show, :create, :destroy, :edit, :update] do
    resources :item_transactions, only: [:new, :create, :show]
    resources :comments, only: [:create , :destroy]
    resources :favorites, only: [:create, :destroy]
    collection do
      post 'upload_image'
    end
  end
  get 'mypage/identification', to: 'users#identification'
  resources :categories, only: [:index, :show] do
    collection do
      get 'size_brand'
    end
  end
  resources :postage_selects, only: [:index]
  resources :credits, path: 'mypage/card', only: [:new, :create, :index, :destroy]
  resources :sales_amounts, path: 'mypage/sales', only: [:index]
  resources :listings, path: 'mypage/listings', only: [:index] do
    collection do
      get 'listing'
      get 'in_progress'
      get 'sold'
    end
  end
end
