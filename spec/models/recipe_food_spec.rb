require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:recipe) do
    Recipe.create(name: 'Test Recipe', preparation_time: 30, cooking_time: 60, description: 'This is test recipe',
                  user:)
  end
  let(:food) { Food.create(name: 'Ingredient', measurement_unit: 'grams', price: 2.99) }
  let(:recipe_food) { RecipeFood.create(quantity: 2, food:, recipe:) }

  it 'should valid with a quantity, a food, and a recipe' do
    expect(recipe_food).to be_valid
  end
  it 'should not valid without a quantity' do
    recipe_food.quantity = nil
    expect(recipe_food).to_not be_valid
  end
  it 'should not valid with a quantity less than 0' do
    recipe_food.quantity = -1
    expect(recipe_food).not_to be_valid
  end
  it 'should not valid without a food' do
    recipe_food.food = nil
    expect(recipe_food).to_not be_valid
  end
  it 'should not valid without a recipe' do
    recipe_food.recipe = nil
    expect(recipe_food).to_not be_valid
  end
  it 'should belongs to a recipe' do
    association = RecipeFood.reflect_on_association(:recipe)
    expect(association.macro).to eq(:belongs_to)
  end
  it 'should belongs to a food' do
    association = RecipeFood.reflect_on_association(:food)
    expect(association.macro).to eq(:belongs_to)
  end

  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:recipe_id) }
    it { should validate_presence_of(:food_id) }
  end
end
