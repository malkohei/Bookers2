Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  root to: 'homes#top'
  get "home/about" => "homes#about"
  get "/users" => "users#index"
  get 'books/show'
  post "/books/create" => "books#create"


  resources :books
  resources :users
end
