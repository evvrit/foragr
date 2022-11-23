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
    @cache = Cache.new
    authorize @cache
  end

  def show
    authorize @cache
  end

  def new
    @cache = Cache.new
    authorize @cache
  end

  def create
    @cache = Cache.create(
      longitude: params[:cache][:longitude],
      latitude:  params[:cache][:latitude],
      user: current_user,
      description: params[:cache][:description],
      found_on: params[:cache][:found_on]
    )
    if @cache.save
      redirect_to cache_path(@cache)
    else
      render :new, status: 422
    end
    authorize @cache
  end

  private

  def set_cache
    @cache = Cache.find(params[:id])
  end
end
