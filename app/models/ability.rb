class Ability
  include CanCan::Ability

  def initialize(resource)
    @resource = resource || User.new
    alias_action :read, :update, :destroy, :to => :modify

    can :manage, User, id: @resource.id

    # For Review
    can :read, Review, view_scope: "public"
    can :read, Review, {view_scope: "private", owner_id: @resource.id}
    can :read, Review, {view_scope: "private", writer_id: @resource.id}

    # For Trip
    can :read, Trip
    can :join, Trip
    can :modify, Trip, owner_id: @resource.id

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
