class CachesController < ApplicationController
  def index
    @caches = Cache.all
  end
end
