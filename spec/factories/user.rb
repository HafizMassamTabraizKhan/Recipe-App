FactoryBot.define do
  factory :user do
    name { 'User Name' }
    email { 'user@example.com' }
    password { 'password123' }
  end
end
