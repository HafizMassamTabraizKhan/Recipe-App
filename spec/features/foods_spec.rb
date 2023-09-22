require 'rails_helper'

RSpec.feature 'Food Details', type: :feature do
  let(:food) { create(:food) }

  before do
    visit food_path(food)
  end

  scenario 'shows the food details' do
    expect(page).to have_content(food.name)
    expect(page).to have_content(food.measurement_unit)
    expect(page).to have_content("$ #{food.price}")
  end

  scenario 'has a back link' do
    expect(page).to have_link('Back', href: foods_path)
  end
end
