class SpeciesController < ApplicationController
  before_action :set_species, only: :show

  def show
    authorize @species
  end

  private

  def set_species
    @species = Species.find(params[:id])
  end
end
