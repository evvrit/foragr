class Log < ApplicationRecord
  belongs_to :user
  has_one :cache

end
