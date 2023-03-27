class SpeciesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  before_action :set_species, only: %i[show toggle_favorite]
  after_action :verify_authorized, except: [:toggle_favorite]

  def show
    # raise
    authorize @species
    if current_user
      @species_favorites = current_user.favorites_by_type('Species')
      # raise
      @specieses = @species_favorites.map do |species_favorite|
        @fav_spec = Species.find_by(id: species_favorite.favoritable_id)
        authorize @fav_spec
      end
      # raise
      authorize @species_favorites
    end
  end

  def search
    if params[:query] == "" || Species.search_by_name(params[:query]) == []
      # raise
      @species = Species.all
    else
      @species = Species.search_by_name(params[:query])
    end
    authorize @species
  end

  def create(query)
    @species = species_scraper(query)
    authorize @species
  end

  def toggle_favorite
    # raise
    current_user.favorited?(@species) ? current_user.unfavorite(@species) : current_user.favorite(@species)
  end

  private

  def set_species
    @species = Species.find(params[:id])
  end
end
