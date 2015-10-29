class Location < ActiveRecord::Base
  include HasEvents
  include Comparable
  validates :name, presence: true, uniqueness: true
  validates :link, format: { with: URI.regexp }, if: Proc.new { |a| a.link.present? }

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

  def to_schema
    { 
      '@context': 'http://schema.org',  
      '@type': 'Place',
      name: self.name,
      address: self.full_address,
      description: self.description,
      'sameAs': self.link
    }
  end
end