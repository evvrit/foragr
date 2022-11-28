class Species < ApplicationRecord
  has_one :cache_species

  validates :name, presence: true
  validates :description, length: { minimum: 30 }
  validates :edible?, inclusion: [true, false]
  validates :edible?, exclusion: [nil]
  validates :photo_url, presence: true
  validates :season, inclusion: { in: ["spring", "summer", "fall", "winter"] }
end
