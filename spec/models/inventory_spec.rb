require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
  let(:inventory) { Inventory.create(name: 'Inventory 1', description: 'This is inventory 1', user:) }

  it 'should create a valid inventory' do
    expect(inventory.valid?).to eq true
  end
  it 'should have a user' do
    inventory.user = nil
    expect(inventory).not_to be_valid
  end
  it 'should have a name' do
    inventory.name = nil
    expect(inventory).not_to be_valid
  end
  it 'should have a valid description' do
    inventory.description = nil
    expect(inventory).not_to be_valid
  end

  it 'should belong to a user' do
    association = Inventory.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
  it 'should have many inventory_foods' do
    association = Inventory.reflect_on_association(:inventory_foods)
    expect(association.macro).to eq(:has_many)
  end
  it 'should have many foods through inventory_foods' do
    association = Inventory.reflect_on_association(:foods)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:inventory_foods)
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:inventory_foods) }
    it { should have_many(:foods).through(:inventory_foods) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:description) }
  end
end
