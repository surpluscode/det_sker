class Location < ActiveRecord::Base
  validates :street_address, :town, presence: true
  has_many :events
end