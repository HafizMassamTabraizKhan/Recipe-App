class RecipeFoodsController < ApplicationController
  def index; end

  def show; end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.all
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'Ingredient successfully added.'
    else
      puts @recipe_food.errors.full_messages
      render 'new'
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    @foods = Food.all
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe

    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe), notice: 'Ingredient successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    if @recipe_food.destroy
      redirect_to recipe_path(@recipe), notice: 'Ingredient successfully removed.'
    else
      redirect_to recipe_path(@recipe), alert: 'Failed to remove ingredient.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
