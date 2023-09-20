class ShoppingListsController < ApplicationController
  def shopping_list
    @inventory_obj = Inventory.find(params[:selected_inventory_id])
    @recipe_obj = Recipe.find(params[:selected_recipe_id])

    food_names_from_inventory = @inventory_obj.inventory_foods.map do |inventory_food|
      inventory_food.food.name.downcase
    end

    @missing_foods = []
    @recipe_obj.recipe_foods.each do |recipe_food|
      inventory_name = recipe_food.food.name.downcase
      if food_names_from_inventory.include?(inventory_name)
        inventory_food = @inventory_obj.inventory_foods.find { |ifood| ifood.food.name.downcase == inventory_name }
        if inventory_food.quantity < recipe_food.quantity

          @missing_foods << {
            food: inventory_food.food,
            quantity_needed: recipe_food.quantity - inventory_food.quantity
          }
        end
      else

        @missing_foods << {
          food: recipe_food.food,
          quantity_needed: recipe_food.quantity
        }
      end
    end

    @total_price = 0
    @missing_foods.each do |missing_food|
      price_multiply_with_qty = missing_food[:food].price * missing_food[:quantity_needed]
      @total_price += price_multiply_with_qty
    end

    @total_price
  end
end
