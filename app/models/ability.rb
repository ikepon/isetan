class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 1
      can :manage, :all
    elsif user.role == 2
      # 会社アカウントで本の貸出を管理
    else
      # 管理者以外
    end
  end
end
