class Food < ApplicationRecord
  has_many :inventory_foods, dependent: :destroy
  has_many :inventories, through: :inventory_foods

  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :name, :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
