class Cache < ApplicationRecord
  belongs_to :user
  has_many :cache_species
  has_many :species, through: :cache_species
  accepts_nested_attributes_for :cache_species,
                                reject_if: :all_blank,
                                allow_destroy: true
  has_many :logs
  has_many_attached :photos


  validates :longitude, :latitude, presence: true
  validates :description, presence: true
  validates :found_on, presence: true
  validates :title, presence: true

  acts_as_favoritable
end
