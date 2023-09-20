Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'

  resources :inventories, only: [:index, :new, :show, :create, :update, :destroy] do
    resources :inventory_foods, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  end
end

