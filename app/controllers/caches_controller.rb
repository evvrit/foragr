class CachesController < ApplicationController
  before_action :set_cache, only: %i[show toggle_favorite]
  after_action :verify_authorized, except: [:toggle_favorite]

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
    @cache_favorites = current_user.favorites_by_type('Cache')
    @caches = @cache_favorites.map do |cache_favorite|
      @fav_cache = Cache.find_by(id: cache_favorite.favoritable_id)
      authorize @fav_cache
    end
    authorize @cache_favorites
    @markers = [{
      lat: @cache.latitude,
      lng: @cache.longitude,
      cache_info: render_to_string(partial: "cache_info", locals: {cache: @cache})
    }]
  end

  def new
    @cache = Cache.new
    authorize @cache
    # raise
    @markers = [{
      lat: params["lat"],
      lng: params["lng"]
    }]
  end

  def create
    @cache = Cache.new(cache_params)
    @cache.user = current_user
    if @cache.save
      redirect_to cache_path(@cache)
    else
      render :new, status: 422
    end
    authorize @cache
  end

  def toggle_favorite
    current_user.favorited?(@cache) ? current_user.unfavorite(@cache) : current_user.favorite(@cache)
  end

  private

  def set_cache
    @cache = Cache.find(params[:id])
  end

  def cache_params
    params.require(:cache).permit(:longitude, :latitude, :description, :found_on, photos: [])
  end
end
