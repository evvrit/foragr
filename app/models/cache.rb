class Cache < ApplicationRecord
  belongs_to :user
  has_one :cache_species
  has_many :species, through: :cache_species


  validates :longitude, :latitude, presence: true
  validates :description, length: { minimum: 30 }
  validates :found_on, presence: true
end
