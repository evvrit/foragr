class Species < ApplicationRecord
  has_one :cache_species

  validates :name, presence: true
  validates :overview, presence: true
  validates :edible, presence: true
  validates :photos, presence: true
  validates :habitat, presence: true
end
