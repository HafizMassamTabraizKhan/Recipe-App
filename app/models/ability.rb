class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :manage, Inventory, user_id: user.id
    can :manage, Food, user_id: user.id
    can :manage, InventoryFood, inventory: { user_id: user.id }
  end
end
