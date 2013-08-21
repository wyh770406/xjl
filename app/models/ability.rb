class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :admin
      can :manage, :all
      cannot :manage, CashflowSubject
    elsif user.is? :accountant
      can :manage, :all

      cannot :manage, Company
      cannot :manage, User
      cannot :manage, CorrespondingSubject

    elsif user.is? :manager
      can :manage, :all

      cannot :manage, Company
      cannot :manage, User
      cannot :manage, CorrespondingSubject
      cannot :manage, CashflowSubject
    else

    end
  end
end
