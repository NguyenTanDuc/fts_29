class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, [Category, Question, User]
      can [:create], Exam
      can [:read, :update], Exam, user_id: user.id
      can :update, Exam, user_id: user.id
    elsif user.normal?
      can :create, Exam
      can [:read, :update], Exam, user_id: user.id
      can :update, User, id: user.id
    end
  end
end
