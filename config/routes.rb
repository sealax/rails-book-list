Rails.application.routes.draw do
  get "bookmarks/new"
  get "bookmarks/create"
  get "bookmarks/destroy"
  root to: "lists#index"
  resources :lists, only: [ :index, :show, :new, :create, :destroy ] do
    resources :bookmarks, only: [ :new, :create ]
  end

  resources :bookmarks, only: [ :destroy ]
end
