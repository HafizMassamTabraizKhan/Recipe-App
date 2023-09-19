class RecipesController < ApplicationController
   load_and_authorize_resource
  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize! :destroy, @recipe
    if @recipe.destroy
      flash[:notice] = "Recipe was successfully deleted."
    else
      flash[:alert] = "Error deleting the recipe."
    end
    redirect_to recipes_path
  end
end
