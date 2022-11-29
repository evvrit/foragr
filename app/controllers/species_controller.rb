class SpeciesController < ApplicationController
  before_action :set_species, only: %i[show toggle_favorite]
  after_action :verify_authorized, except: [:toggle_favorite]

  def show
    authorize @species
    if params[:query] == "" || Species.search_by_name(params[:query]) == []
      # raise
      @species = Species.all
    else
      @species = Species.search_by_name(params[:query])
    end
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
