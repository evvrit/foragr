class Species < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
  has_one :cache_species

  validates :name, presence: true
  validates :overview, presence: true
  validates :edible, presence: true
  validates :photos, presence: true
  validates :habitat, presence: true
end
