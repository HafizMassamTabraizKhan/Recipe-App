class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, class_name: 'Recipe', dependent: :destroy
  has_many :inventories, class_name: 'Inventory', dependent: :destroy
  validates :name, presence: true
end
