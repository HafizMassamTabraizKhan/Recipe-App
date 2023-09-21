class Food < ApplicationRecord
  has_many :inventory_foods, dependent: :destroy
  has_many :inventories, through: :inventory_foods

  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :name, uniqueness: true, presence: true
  validates :measurement_unit, presence: true
  validate :name_is_unique_case_insensitive, on: :create
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def name_is_unique_case_insensitive
    return unless Food.where('LOWER(name) = ?', name.downcase).exists?

    errors.add(:name, 'has already been taken (case-insensitive)')
  end
end
