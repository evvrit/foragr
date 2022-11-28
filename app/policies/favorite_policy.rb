class FavoritePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def caches?
    true
  end

  def species?
    true
  end
end
