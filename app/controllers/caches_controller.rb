class CachesController < ApplicationController
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
end
