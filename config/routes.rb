Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'mypage' => 'users#mypage'
  get 'mypage/card' => 'users#card'
  get 'mypage/card/add' => 'users#add'
  resources :items, only: [:new]
  resources :transaction, only: [:new]
  get 'users/logout', to: 'users#logout'
end
