require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:recipe) do
    Recipe.new(name: 'Pizza', description: 'Delicious Pizza', preparation_time: 30, cooking_time: 50, user:)
  end
  it 'should create a valid recipe' do
    expect(recipe.valid?).to eq true
  end
  it 'should have a user' do
    recipe.user = nil
    expect(recipe).not_to be_valid
  end
  it 'should have a name' do
    recipe.name = nil
    expect(recipe).not_to be_valid
  end
  it 'should have a valid preparation time' do
    recipe.preparation_time = nil
    expect(recipe).not_to be_valid
  end
  it 'should have a valid cooking time' do
    recipe.cooking_time = nil
    expect(recipe).not_to be_valid
  end
  it 'should have a valid description' do
    recipe.description = nil
    expect(recipe).not_to be_valid
  end
  it 'should belong to a user' do
    association = Recipe.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
  it 'should have many recipe_foods' do
    association = Recipe.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq(:has_many)
  end
  it 'should have many foods through recipe_foods' do
    association = Recipe.reflect_on_association(:foods)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:recipe_foods)
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods) }
    it { should have_many(:foods).through(:recipe_foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:preparation_time) }
    it { should validate_presence_of(:cooking_time) }
    it { should validate_presence_of(:user_id) }
  end
end
