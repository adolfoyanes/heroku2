Rails.application.routes.draw do
  get 'auth_ml/auth_response'
  get 'conectar_ml', to: "conectar_ml#index"
  devise_for :users
  resources :items
  resources :sellers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
