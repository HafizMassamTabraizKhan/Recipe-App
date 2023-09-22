FactoryBot.define do
  factory :inventory do
    name { 'Inventory Name' }
    user { create(:user) }
    user_id { user.id }
    description { 'Inventory Description' }
  end
end
