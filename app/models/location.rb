class Location < ActiveRecord::Base
  include HasEvents
  include Comparable
  validates :name, presence: true, uniqueness: true

  def display_name
    name.present? ? name : street_address
  end

  # combined address as single string without nil vals
  def full_address
    [name, street_address, postcode, town]
        .reject(&:empty?)
        .join(', ')
  end

  def address
    [street_address, postcode, town]
        .reject(&:empty?)
        .join(', ')
  end

  def <=>(other)
    display_name.downcase <=> other.display_name.downcase
  end

  # need to overwrite this method to show display_name
  # in json response
  def as_json(opts)
    super(methods: [:display_name])
  end
end