class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Recipe

    if user.persisted?
      can :manage, Recipe, user_id: user.id
      can :create, Recipe
      can :update, Recipe do |recipe|
        recipe.user_id == user.id
      end
      can :destroy, Recipe do |recipe|
        recipe.user_id == user.id
      end
    end

    can :manage, Inventory, user_id: user.id
    can :manage, Food, user_id: user.id
    can :manage, InventoryFood, inventory: { user_id: user.id }
  end
end
