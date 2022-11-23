class Log < ApplicationRecord
  belongs_to :user
  belongs_to :cache, optional: true

  validates :content, length: { minimum: 30 }
  validates :created_on, presence: true
end
