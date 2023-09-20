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

  def create; end

  def edit; end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      # Handle successful update
      redirect_to @recipe, notice: 'Recipe updated successfully'
    else
      # Handle validation errors
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize! :destroy, @recipe
    if @recipe.destroy
      flash[:notice] = 'Recipe was successfully deleted.'
    else
      flash[:alert] = 'Error deleting the recipe.'
    end
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:public)
  end
end
