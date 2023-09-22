FactoryBot.define do
  factory :recipe do
    name { 'Recipe Name' }
    preparation_time { 3 }
    cooking_time { 4 }
    description { 'Recipe Description' }
    public { true }
  end
end
