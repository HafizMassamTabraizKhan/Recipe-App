# spec/features/recipe_show_spec.rb

require 'rails_helper'

RSpec.feature 'Recipe Show Page', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user, name: 'Sample Recipe', public: true) }

  before do
    login_as(user, scope: :user) # Use Warden's login_as method to log in the user
  end

  scenario 'User views the recipe details' do
    visit recipe_path(recipe)

    # Assertions to check the content of the page
    expect(page).to have_selector('h1.recipe-page-title', text: 'Sample Recipe')
    expect(page).to have_content("Preparation time: #{recipe.preparation_time}")
    expect(page).to have_content("Cooking time: #{recipe.cooking_time}")
    expect(page).to have_content('Steps go here')

    within('.details-wrapper') do
      expect(page).to have_content('public recipes') # Corrected spelling to 'Public'
      expect(page).to have_selector('form#recipe-form')
      expect(page).to have_selector('input#public-checkbox')
    end

    within('.actions') do
      expect(page).to have_button('Generate Shopping List', id: 'myBtn')
      expect(page).to have_selector('div#myModal')
      expect(page).to have_selector('form[action="/shopping_list"]')
      expect(page).to have_select('selected_inventory_id', options: ['.. Select an Inventory ..'] + user.inventories.pluck(:name))
      expect(page).to have_button('Generate')
      expect(page).to have_link('Add ingredient', href: new_recipe_recipe_food_path(recipe))
    end

    expect(page).to have_selector('h2', text: 'Food Items -- Ingredients')

    within('table') do
      expect(page).to have_selector('thead')
      expect(page).to have_selector('tbody')

      recipe.recipe_foods.each do |recipe_food|
        expect(page).to have_content(recipe_food.food.name)
        expect(page).to have_content(recipe_food.quantity)
        expect(page).to have_content("$ #{(recipe_food.food.price * recipe_food.quantity).to_f.round(2)}")
        expect(page).to have_link('Modify', href: edit_recipe_recipe_food_path(recipe, recipe_food))
        expect(page).to have_link('Remove', href: recipe_recipe_food_path(recipe, recipe_food))
      end
    end
  end
end
