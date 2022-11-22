class Log < ApplicationRecord
  belongs_to :user
  has_one :cache

  validates :content, length: { minimum: 30 }
  validates :created_on, presence: true
end
