require 'rails_helper'

RSpec.feature 'Inventory Index', type: :feature do
  let(:inventory) { create(:inventory) }

  before do
    create(:inventory_food, inventory:, food: create(:food))
    visit inventory_path(inventory)
  end

  scenario 'shows the inventory name' do
    expect(page).to have_content(inventory.name)
  end

  scenario 'has an add food link' do
    expect(page).to have_link('Add Food', href: new_inventory_inventory_food_path(inventory))
  end

  scenario 'shows the inventory foods' do
    expect(page).to have_content(inventory.inventory_foods.first.food.name)
  end
end
