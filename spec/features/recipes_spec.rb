require 'rails_helper'

RSpec.feature 'Shopping List Page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:inventory) { FactoryBot.create(:inventory, user:, name: 'Sample Inventory') }
  let(:recipe) { FactoryBot.create(:recipe, user:, name: 'Sample Recipe') }
  let(:missing_foods) { [] }

  before do
    login_as(user)
    bread = FactoryBot.create(:food, name: 'Bread', price: 2.5)
    milk = FactoryBot.create(:food, name: 'Milk', price: 3.5)
    recipe.recipe_foods.create(food: bread, quantity: 1)
    recipe.recipe_foods.create(food: milk, quantity: 2)

    visit shopping_list_path(recipe_id: recipe.id, inventory_id: inventory.id, selected_inventory_id: inventory.id)
  end

  def calculate_missing_foods
    recipe.recipe_foods.each do |recipe_food|
      missing_quantity = recipe_food.quantity - inventory.inventory_foods.where(food: recipe_food.food).sum(:quantity)
      missing_foods << { food: recipe_food.food, quantity_needed: missing_quantity } if missing_quantity.positive?
    end
  end

  scenario 'User views the shopping list details' do
    # Calculate the missing foods
    calculate_missing_foods

    # Assertions to check the content of the page
    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Amount of food to buy: 2')
    expect(page).to have_link('Sample Recipe', href: recipe_path(recipe))
    expect(page).to have_content('Total value of food needed: $9.5')
    expect(page).to have_link('Sample Inventory', href: inventory_path(inventory))

    within('table') do
      expect(page).to have_content('Bread')
      expect(page).to have_content('1')
      expect(page).to have_content('$2.5')
      expect(page).to have_content('Milk')
      expect(page).to have_content('2')
      expect(page).to have_content('$7.0')
    end
  end
end
