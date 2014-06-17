class Location < ActiveRecord::Base
  include HasEvents
  validates :street_address, :town, presence: true
end