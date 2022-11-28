class SpeciesController < ApplicationController
  before_action :set_species, only: :show

  def show
    authorize @species
  end

  def create(query)
    @species = species_scraper(query)
    authorize @species
  end

  private

  def set_species
    @species = Species.find(params[:id])
  end

  # def clean_up
  #   .delete '[]\""'
  # end
end
