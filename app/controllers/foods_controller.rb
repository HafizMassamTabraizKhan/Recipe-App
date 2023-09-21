class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to @food, notice: 'Food item was successfully created.'
    else
      render :new
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      redirect_to @food, notice: 'Food item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_url, notice: 'Food item was successfully destroyed.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
