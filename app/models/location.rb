class Location < ActiveRecord::Base
  include HasEvents
  include Comparable
  validates :street_address, :town, presence: true

  def display_name
    name.present? ? name : street_address
  end

  def <=>(other)
    display_name <=> other.display_name
  end
end