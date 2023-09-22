class InventoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @inventories = Inventory.includes(:inventory_foods).where(user_id: current_user.id)
  end

  def new
    @inventory = Inventory.new
    @foods = Food.all # Fetch a collection of all food items
    @inventory_food = InventoryFood.new
  end

  def show
    @inventory = Inventory.find(params[:id])
  end

  def create
    @inventory = current_user.inventories.build(inventory_params)
    if @inventory.save
      flash[:notice] = 'Inventory created successfully.'
      redirect_to inventories_path
    else
      flash.now[:alert] = 'Inventory creation failed.'
      render :new # Render the 'new' view to show validation errors and preserve form data
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])

    if @inventory.inventory_foods.empty?
      if @inventory.destroy
        flash[:notice] = 'Inventory deleted successfully.'
      else
        flash[:alert] = 'Inventory could not be deleted.'
      end
    else
      flash[:alert] = 'Inventory has associated foods and cannot be deleted.'
      redirect_to inventory_path(@inventory)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end

  def can_manage_inventory?(inventory)
    inventory.user == current_user
  end
end
