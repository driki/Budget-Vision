class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    can :read, Organization
    can :read, Project
    can :read, Category
    can :read, Item
    can :read, Goal
    can :read, Forecast
    can :read, User

    if !user.nil?
      can :create, Organization
      can :create, Project
      can :create, Category
      can :create, Item
      can :create, Goal
      can :create, Forecast
      can :create, User

      can :manage, Organization do |organization|
        organization.users.include?(user)
      end
      can :manage, Project do |project|
        project.organization.users.include?(user)
      end
    end
  end
end
