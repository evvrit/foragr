class CachePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index
    true
  end

  def toggle_favorite
    true
  end

  def caches?
    true
  end
end
