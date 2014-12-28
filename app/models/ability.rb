class Ability
  include CanCan::Ability

  def initialize(user)
      if user.role?
        can :manage, :all
      else
        # 管理者以外
      end
    end
end
