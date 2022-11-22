class CachesController < ApplicationController
  def index
    @caches = policy_scope(Cache)
    authorize @caches
  end
end
