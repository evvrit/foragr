class LogPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def css_test?
    true
  end

  def create?
    true
  end

  def index?
    record.user_id == user.id
  end

  def show?
    record.user_id == user.id
  end
end
