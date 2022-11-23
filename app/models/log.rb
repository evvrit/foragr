class Log < ApplicationRecord
  belongs_to :user
  belongs_to :cache, optional: true
  has_one_attached :photo

  validates :content, length: { minimum: 10 }
  validates :created_on, presence: true
end
