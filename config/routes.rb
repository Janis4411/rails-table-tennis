Rails.application.routes.draw do
  devise_for :users
  resources :tables, only: [:new, :edit, :index, :destroy, :update, :create]

  get '/user/tables', to: 'tables#user_index', as: 'user_index'
  root to: "tables#index"
end
