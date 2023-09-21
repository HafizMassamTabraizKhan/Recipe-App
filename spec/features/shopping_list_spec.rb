# spec/features/shopping_list_spec.rb

require 'rails_helper'

RSpec.feature 'Shopping List Page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:inventory) { FactoryBot.create(:inventory, user: user, name: 'Sample Inventory') }
  let(:recipe) { FactoryBot.create(:recipe, user: user, name: 'Sample Recipe') }
  let(:food1) { FactoryBot.create(:food, name: 'Food 1', price: 5.0) }
  let(:food2) { FactoryBot.create(:food, name: 'Food 2', price: 10.0) }
  let(:food3) { FactoryBot.create(:food, name: 'Food 3', price: 15.0) }

  before do
    login_as(user)
    recipe.recipe_foods.create(food: food1, quantity: 2)
    recipe.recipe_foods.create(food: food2, quantity: 3)
    inventory.inventory_foods.create(food: food2, quantity: 1)

    # Stub the selected_inventory_id in params
    allow_any_instance_of(ActionController::Parameters).to receive(:[]).with(:selected_inventory_id).and_return(inventory.id)

    # visit shopping_list_path(recipe_id: recipe.id, inventory_id: inventory.id)
  end

  scenario 'User views the shopping list details' do
    # Assertions to check the content of the page
    expect(page).to have_content("Amount of food to buy: #{food1.name}: 2, #{food2.name}: 2, #{food3.name}: 5")
    expect(page).to have_link('Sample Recipe', href: recipe_path(recipe))
    expect(page).to have_content("Total value of food needed: $#{(food1.price * 2 + food2.price * 2 + food3.price * 5).to_f}")
    expect(page).to have_link('Sample Inventory', href: inventory_path(inventory))

    within('table') do
      expect(page).to have_selector('thead')
      expect(page).to have_selector('tbody')

      expect(page).to have_content('Serial#')
      expect(page).to have_content('Food')
      expect(page).to have_content('Quantity')
      expect(page).to have_content('Price')

      expect(page).to have_content('1')
      expect(page).to have_content(food1.name)
      expect(page).to have_content('2')
      expect(page).to have_content("$#{(food1.price * 2).to_f}")

      expect(page).to have_content('2')
      expect(page).to have_content(food2.name)
      expect(page).to have_content('2')
      expect(page).to have_content("$#{(food2.price * 2).to_f}")

      expect(page).to have_content('3')
      expect(page).to have_content(food3.name)
      expect(page).to have_content('5')
      expect(page).to have_content("$#{(food3.price * 5).to_f}")
    end
  end
end
