Rails.application.routes.draw do
  get 'auth_ml/auth_response'
  get 'conectar_ml', to: "conectar_ml#index"
  devise_for :users
  resources :items
  resources :sellers
  get 'sotock_ml/syncup', to: "stock_ml#sink_up"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
