class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_foods, class_name: 'RecipeFood', dependent: :destroy
  has_many :foods, through: :recipe_foods

  attribute :public, :boolean, default: false

  validates :user_id, :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true
end
