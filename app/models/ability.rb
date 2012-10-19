class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :choose_client, User if user.role == "support"
    can :choose_assigned, User if user.role == "support"
    can :filer_form, User if user.role == "support"
    can :filer_status, User if user.role == "client"
    can :see_assigend, User if user.role == "client"

  end
end
