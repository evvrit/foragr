class CachesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
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
    if current_user
      @cache_favorites = current_user.favorites_by_type('Cache')
      @caches = @cache_favorites.map do |cache_favorite|
        @fav_cache = Cache.find_by(id: cache_favorite.favoritable_id)
        authorize @fav_cache
      end
      authorize @cache_favorites
    end

    @markers = [{
      lat: @cache.latitude,
      lng: @cache.longitude,
      cache_info: render_to_string(partial: "cache_info", locals: { cache: @cache })
    }]
    # authorize @markers.first
  end

  def new
    @cache = Cache.new(latitude: params["lat"], longitude: params["lng"])
    authorize @cache
    @cache.cache_species.build unless @cache.cache_species.any?
    @species = Species.all.map { |species| [species.name, species.id] }
    @markers = [{
      lat: params["lat"],
      lng: params["lng"],
      cache_info: "#{params['lat']}, #{params['lng']}"
    }]
  end

  def create
    @cache = Cache.new(cache_params)
    @cache.user = current_user
    if @cache.save
      # raise
      redirect_to cache_path(@cache)
    else
      @species = Species.all.map { |species| [species.name, species.id] }
      @markers = [{
        lat: params["cache"]["latitude"],
        lng: params["cache"]["longitude"]
        }]
      # flash.now[:alert] = "Please include a short title and a description with at least 10 characters."
      # redirect_to action: :new, status: 422
      # render partial: "form", locals: {cache: @cache}, status: 422
      render :new, status: 422
      # raise
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
    params.require(:cache).permit(:title, :longitude, :latitude, :description, :log_id, :found_on, photos: [],
                                  cache_species_attributes: %i[id species_id _destroy])
  end
end
