class Food < ApplicationRecord
  has_many :inventory_foods
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  validates :name, uniqueness: true 
  validate :name_is_unique_case_insensitive, on: :create 

  private

  def name_is_unique_case_insensitive
    if Food.where('LOWER(name) = ?', name.downcase).exists?
      errors.add(:name, 'has already been taken (case-insensitive)')
    end
  end
end
