Rails.application.routes.draw do
  post 'notifications', to: "notifications#index"
  get 'auth_ml/auth_response'
  get 'conectar_ml', to: "conectar_ml#index"
  devise_for :users
  resources :items
  resources :sellers
  get 'stock_ml/syncup', to: "stock_ml#sink_up"
  get 'stock_ml', to: "stock_ml#index", as: "stock_ml"
  get 'stock_ml/:id/edit', to: "stock_ml#edit", as: "stock_ml_edit"
  put 'stock_ml/:id/update', to: "stock_ml#update", as: "stock_ml_update"
  get 'stock_ml/test_worker', to: "stock_ml#test_worker", as: "stock_ml_test_worker"
  post 'stock_ml/test_worker/test', to: "stock_ml#do_test_worker", as: "stock_ml_do_test"
  get 'stock_ml/test_worker_pause_items', to: "stock_ml#pause_items_worker", as: "stock_ml_test_worker_pause"
  post 'stock_ml/test_worker_pause_items/pause', to: "stock_ml#pause_all_items", as: "stock_ml_do_test_worker_pause"
  #put 'stock_ml/:id/update', to: "stock_ml#update", as: "stock_ml_update"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
