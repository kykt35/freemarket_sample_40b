Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'mypage' => 'users#index'
  get 'mypage/card' => 'users#card'
  get 'mypage/card/add' => 'users#add'
end
