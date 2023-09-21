require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { Food.create(name: 'Apple', measurement_unit: 'grams', price: 0.5) }

  it 'should valid with valid attributes' do
    expect(food).to be_valid
  end
  it 'should not valid without a name' do
    food.name = nil
    expect(food).not_to be_valid
  end
  it 'should not valid with a negative price' do
    food.price = -1
    expect(food).not_to be_valid
  end
  it 'should valid with a price of zero' do
    food.price = 0
    expect(food).to be_valid
  end

  it 'should have many inventory_foods' do
    association = Food.reflect_on_association(:inventory_foods)
    expect(association.macro).to eq(:has_many)
  end

  it 'should have many inventories through inventory_foods' do
    association = Food.reflect_on_association(:inventories)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:inventory_foods)
  end

  it 'should have many recipe_foods' do
    association = Food.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq(:has_many)
  end

  it 'should have many recipes through recipe_foods' do
    association = Food.reflect_on_association(:recipes)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:recipe_foods)
  end

  describe 'associations' do
    it { should have_many(:inventory_foods).dependent(:destroy) }
    it { should have_many(:inventories).through(:inventory_foods) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
    it { should have_many(:recipes).through(:recipe_foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:measurement_unit) }
    it { should validate_presence_of(:price) }
  end
end
