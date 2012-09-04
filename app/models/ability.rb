class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :choose_client, User if user.role == "support" 

  end
end
