class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # Guest user (unauthenticated)

    # Define abilities based on user roles
    return unless user.persisted? # Check if the user is authenticated

    can :manage, Recipe, user_id: user.id
  end
end
