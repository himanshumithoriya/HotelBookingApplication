# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.owner?
      can :manage, Hotell
    end
  end
end
