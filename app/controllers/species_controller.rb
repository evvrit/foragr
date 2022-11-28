class SpeciesController < ApplicationController
  before_action :set_species, only: :show

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

  private

  def set_species
    @species = Species.find(params[:id])
  end
end
