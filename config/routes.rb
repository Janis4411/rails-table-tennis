Rails.application.routes.draw do
  devise_for :users
  resources :tables
  root to: "tables#index"
end
