class Category < ActiveRecord::Base
  validates :key, presence: true
  has_and_belongs_to_many :events
end
