require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:inventory) { Inventory.create(name: 'Inventory 1', description: 'This is inventory 1', user:) }
  let(:food) { Food.create(name: 'Ingredient', measurement_unit: 'grams', price: 2.99) }
  let(:inventory_food) { InventoryFood.new(quantity: 2, food:, inventory:) }

  it 'should valid with a quantity, a food, and a recipe' do
    expect(inventory_food).to be_valid
  end
  it 'should not valid without a quantity' do
    inventory_food.quantity = nil
    expect(inventory_food).to_not be_valid
  end
  it 'should not valid with a quantity less than 0' do
    inventory_food.quantity = -1
    expect(inventory_food).not_to be_valid
  end
  it 'should not valid without a food' do
    inventory_food.food_id = nil
    expect(inventory_food).to_not be_valid
  end
  it 'should not valid without a inventory' do
    inventory_food.inventory_id = nil
    expect(inventory_food).to_not be_valid
  end

  it 'should belongs to a recipe' do
    association = InventoryFood.reflect_on_association(:inventory)
    expect(association.macro).to eq(:belongs_to)
  end
  it 'should belongs to a food' do
    association = InventoryFood.reflect_on_association(:food)
    expect(association.macro).to eq(:belongs_to)
  end

  describe 'associations' do
    it { should belong_to(:inventory) }
    it { should belong_to(:food) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:inventory_id) }
    it { should validate_presence_of(:food_id) }
  end
end
