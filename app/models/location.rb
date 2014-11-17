class Location < ActiveRecord::Base
  include HasEvents
  validates :street_address, :town, presence: true

  def display_name
    name.present? ? name : street_address
  end
end