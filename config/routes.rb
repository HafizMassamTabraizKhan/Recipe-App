Rails.application.routes.draw do
  get 'public_recipes/index'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #


 resources :recipes do
  resources :recipe_foods
 end

  root 'public_recipes#index'
end
