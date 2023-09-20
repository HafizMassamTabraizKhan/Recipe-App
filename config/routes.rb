Rails.application.routes.draw do
  get 'public_recipes/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'shopping_list/recipe_id/:recipe_id/inventory_id/:inventory_id', to: 'shopping_lists#shopping_list', as: 'shopping_list'
  root 'users#index'
end
