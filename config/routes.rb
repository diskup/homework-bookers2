Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  delete 'users/:id' => 'users#destroy', as: 'destroy_user'
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
end