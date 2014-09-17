class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == 'superadmin'
      can :manage, :all
    elsif user.role == 'admin'
      can :manage, :all
    else
      can :read,    User, id: user.id
      can :create,  User
      can :update,  User, id: user.id
      can :destroy, User, id: user.id
      can :profile, User, id: user.id
      can :read,    Exam
      can :create,  Score, user_id: user.id
      can :read,    Score
    end
  end
end
