class RecipeFoodsController < ApplicationController
  def index; end

  def show; end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build
    @food = @recipe_food.build_food
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    @food = @recipe_food.build_food(food_params)

    if @food.save && @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'Ingredient and quantity were successfully added.'
    else
      render 'new'
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, food_attributes: %i[name measurement_unit price])
  end

  def food_params
    params.require(:recipe_food).require(:food).permit(:name, :measurement_unit, :price)
  end
end
