class Ability
  include CanCan::Ability

  def self.can_user_manage_category?(user, category)
    return category.nil? || Ability.can_user_manage_project?(user, category.project)
  end

  def self.can_user_manage_project?(user, project)
    if project.nil?
      return true
    end
    org = project.organization
    org.nil? || !org.is_verified || org.users.include?(user)
  end

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
    alias_action :states, :trends, :comparisons, :find_by_state_and_name, :to => :read

    can :read, Category # Department superclass
    can :read, Department
    can :read, Forecast
    can :read, Goal
    can :read, Item # Expense, Revenue superclass
    can :read, Expense
    can :read, Revenue
    can :read, Organization
    can :read, Project
    can :read, Source
    can :read, User

    if !user.nil?
      can :create, Category
      can :create, Department
      can :create, Forecast
      can :create, Goal
      can :create, Item
      can :read, Expense
      can :read, Revenue
      can :create, Organization
      can :create, Project
      can :create, Source
      can :create, User

      can :manage, Category do |category|
        Ability.can_user_manage_category?(user, category)
      end

      can :manage, Department do |category|
        Ability.can_user_manage_category?(user, category)
      end

      can :manage, Forecast do |forecast|
        Ability.can_user_manage_project?(user, forecast.project)
      end

      can :manage, Goal do |goal|
        Ability.can_user_manage_project?(user, goal.project)
      end

      can :manage, Item do |item|
        Ability.can_user_manage_category?(user, item.category)
      end

      can :manage, Expense do |item|
        Ability.can_user_manage_category?(user, item.category)
      end

      can :manage, Revenue do |item|
        Ability.can_user_manage_category?(user, item.category)
      end

      can :manage, Organization do |org|
        !org.is_verified || org.owner_id == user.id || org.users.include?(user)
      end

      can :manage, Project do |project|
        Ability.can_user_manage_project?(user, project)
      end

      can :manage, Source do |source|
        Ability.can_user_manage_project?(user, source.project)
      end

      can :manage, User, :uid => user.id
    end
  end
end
