class Ability
  include CanCan::Ability

  def initialize(user)
    #
    user ||= User.new # guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all # admin can do everything
    else
      can :read, :all # everyone can read everything
      can :create, Group # everyone can create groups
      can :create, Entity, author_id: user.id # everyone can create transfer
      can :destroy, Entity, author_id: user.id
    end
  end
end
