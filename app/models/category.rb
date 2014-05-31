class Category < ActiveRecord::Base
  validates :key, presence: true
  has_many :events
end
