Rails.application.routes.draw do
  root 'home#index'
  get 'bookaflight', to: 'flights#bookaflight'
  post 'bookaflight', to: 'flights#passbookaflight'
  get 'passbookaflight', to: 'flights#passbookaflight'
  post 'passbookaflight', to: 'flights#passbookaflight'

  resources :users
  resources :feedbacks
  resources :transactions
  resources :reservations
  resources :flights
  resources :airports

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
