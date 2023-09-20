class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (unauthenticated)

    # return unless user.present?

    can :manage, Inventory, user_id: user.id
    can :manage, Food, user_id: user.id
    can :manage, InventoryFood, inventory: { user_id: user.id }

    # Define abilities based on user roles
    return unless user.persisted? # Check if the user is authenticated

    can :manage, Recipe, user_id: user.id
  end
end
