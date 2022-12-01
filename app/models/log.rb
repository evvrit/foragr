class Log < ApplicationRecord
  belongs_to :user
  belongs_to :cache, optional: true
  has_many_attached :photos

  validates :content, presence: true, length: { minimum: 10 }
  validates :created_on, presence: true
  validates :title, presence: true
end
