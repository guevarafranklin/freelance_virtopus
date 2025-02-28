class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    if user.admin?
      can :manage, :all
    elsif user.client?
      can :read, :all
      can :manage, Job, client_id: user.id
      can :manage, Contract, client_id: user.id
      can :manage, Payment, contract: { client_id: user.id }
      can :read, TimeEntry, contract: { client_id: user.id }
      can :read, Proposal, job: { client_id: user.id }
      can :manage, Profile, user_id: user.id
    elsif user.freelancer?
      can :read, :all
      can :create, Proposal, freelancer_id: user.id
      can :manage, Proposal, freelancer_id: user.id
      can :manage, TimeEntry, freelancer_id: user.id
      can :read, Contract, freelancer_id: user.id
      can :read, Payment, contract: { freelancer_id: user.id }
      can :manage, Profile, user_id: user.id
    else
      can :read, Job
    end
  end
end
