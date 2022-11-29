class Species < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
  has_many :cache_species
  # has_many :caches, through: :cache_species # doesn't seem to access caches through the association

  validates :name, presence: true
  validates :overview, presence: true
  validates :edible, presence: true
  validates :photos, presence: true
  validates :habitat, presence: true
end
