Rails.application.routes.draw do
  root to: "lists#index"
  resources :lists, only: [ :index, :show, :new, :create ]
end
