class FavoritesController < ApplicationController

  def caches
    @cache_favorites = current_user.favorites_by_type('Cache')
    @caches = @cache_favorites.map do |cache_favorite|
      @cache = Cache.find_by(id: cache_favorite.favoritable_id)
      authorize @cache
    end
    authorize @cache_favorites
  end
end
