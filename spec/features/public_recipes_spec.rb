# spec/features/public_recipes_spec.rb

require 'rails_helper'

RSpec.feature 'Public Recipes List', type: :feature do
  scenario 'User views the list of public recipes' do
    # Create some sample data for public recipes
    user = FactoryBot.create(:user, name: 'John Doe')
    public_recipe1 = FactoryBot.create(:recipe, name: 'Recipe 1', user:)
    public_recipe2 = FactoryBot.create(:recipe, name: 'Recipe 2', user:)

    # Visit the public recipes page
    visit root_path

    # Assertions to check the content of the page
    expect(page).to have_selector('h1', text: 'Public Recipes list')

    # Check for each public recipe in the list
    within('.card', text: 'Recipe 1') do
      expect(page).to have_link('Recipe 1', href: recipe_path(public_recipe1))
      expect(page).to have_content('by John Doe')
      expect(page).to have_content('Total food items: 0') # Customize as needed
      expect(page).to have_content('Total price: $0') # Adjusted expectation
    end

    within('.card', text: 'Recipe 2') do
      expect(page).to have_link('Recipe 2', href: recipe_path(public_recipe2))
      expect(page).to have_content('by John Doe')
      expect(page).to have_content('Total food items: 0') # Customize as needed
      expect(page).to have_content('Total price: $0') # Adjusted expectation
    end
  end
end
