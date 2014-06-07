class Location < ActiveRecord::Base
  validates :street_address, :town, presence: true
end