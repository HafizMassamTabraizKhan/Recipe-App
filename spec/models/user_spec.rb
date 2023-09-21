require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should valid with valid attributes' do
    user = User.create(name: 'Massam', email: 'm@example.com', password: 'password')
    expect(user.valid?).to eq true
  end
  it 'should not create a user without a name' do
    user = User.create(email: 'm@example.com', password: 'password')
    expect(user.valid?).to eq false
  end
  it 'should not valid without a password' do
    user = User.create(name: 'Massam', email: 'm@example.com')
    expect(user).not_to be_valid
  end
  it 'should not valid with the duplicate email' do
    User.create(name: 'Peter', email: 'peter@example.com', password: 'password')
    user = User.new(name: 'Abel', email: 'peter@example.com', password: 'password')
    expect(user).not_to be_valid
  end
  it 'should valid with a unique email' do
    User.create(name: 'Peter', email: 'peter@example.com', password: 'password')
    user = User.new(name: 'Abel', email: 'abel@example.com', password: 'password')
    expect(user).to be_valid
  end
  it 'should have many inventories' do
    association = described_class.reflect_on_association(:inventories)
    expect(association.macro).to eq :has_many
  end
  it 'should have many recipes' do
    association = User.reflect_on_association(:recipes)
    expect(association.macro).to eq(:has_many)
  end
end
