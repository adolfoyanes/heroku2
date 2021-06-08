Rails.application.routes.draw do
  get 'auth_ml/auth_response'
  get 'conectar_ml', to: "conectar_ml#index"
  devise_for :users
  resources :items
  resources :sellers
  get 'stock_ml/syncup', to: "stock_ml#sink_up"
  get 'stock_ml', to: "stock_ml#index"
  get 'stock_ml/:id/edit', to: "stock_ml#edit", as: "stock_ml_edit"
  put 'stock_ml/:id/update', to: "stock_ml#update", as: "stock_ml_update"
  #put 'stock_ml/:id/update', to: "stock_ml#update", as: "stock_ml_update"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
