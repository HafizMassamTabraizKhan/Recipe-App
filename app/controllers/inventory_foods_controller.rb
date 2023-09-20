class InventoryFoodsController < ApplicationController
  def index; end

  def show; end

  def new
    @inventory = Inventory.find(params[:inventory_id])
    @foods = Food.all
    @inventory_food = InventoryFood.new
  end

  def create
    @inventory_food = InventoryFood.new(inventory_food_params)
    @inventory = Inventory.find(params[:inventory_id]) # Retrieve the associated inventory

    if @inventory_food.save
      flash[:notice] = 'Inventory created successfully.'
      redirect_to inventory_path(@inventory)
    else
      flash.now[:alert] = 'Inventory creation failed.'
      redirect_to new_inventory_url
    end
  end

  def destroy
    @inventory_food = InventoryFood.find(params[:id]) # Assuming you're looking for an InventoryFood by its ID
    @inventory_food.destroy

    flash[:notice] = 'Inventory Food was successfully deleted.'
    redirect_to inventory_path(:inventory_id)
  end

  private

  def inventory_food_params
    params.require(:inventory_food).permit(:quantity, :inventory_id, :food_id)
  end
end
