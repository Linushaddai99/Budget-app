class Ability
  include CanCan::Ability

  def initialize(user)
    #
    user ||= User.new # guest user (not logged in)

    return unless user.present?

    can(:manage, Group, user:)
    can(:manage, Entity, user:)

    return unless user.is? :admin

    can :manage, :all
  end
end
