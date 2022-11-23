class CachesController < ApplicationController
  before_action :set_cache, only: :show

  def index
    @caches = policy_scope(Cache)
    authorize @caches

    @markers = @caches.map do |cache|
      {
        lat: cache.latitude,
        lng: cache.longitude,
        cache_info: render_to_string(partial: "cache_info", locals: {cache: cache})
      }
    end
  end

  def show
    authorize @cache
  end

  private

  def set_cache
    @cache = Cache.find(params[:id])
  end
end
