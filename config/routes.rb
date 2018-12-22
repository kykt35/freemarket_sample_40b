Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    match "/auth/:provider/callback", to: "sessions#create",via: [:get, :post]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'mypage' => 'users#mypage'
  get 'mypage/card' => 'users#card'
  get 'mypage/card/add' => 'users#add'
  get 'mypage/profile' => 'users#profile'
  get 'users/registration_card' => 'users#registration_card'
  resources :items, only: [:new, :show, :create, :edit, :update]
  resources :transaction, only: [:new]
  get 'users/signup', to: 'users#signup'
  get 'users/logout', to: 'users#logout'
  get 'mypage/identification', to: 'users#identification'
  resources :categories, only: [:index]
  resources :postage_selects, only: [:index]
  get 'categories/size_brand', to: 'categories#size_brand'
end
