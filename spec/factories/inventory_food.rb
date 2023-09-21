FactoryBot.define do
  factory :inventory_food do
    inventory { create(:inventory) }
    food { create(:food) }
    quantity { 10 }
  end
end
