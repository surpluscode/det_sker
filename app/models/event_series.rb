class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_and_belongs_to_many :categories
  has_attached_file :picture, styles: { original: '500x500>', thumb: '100x100>'}, default_url: 'images/:st'
  validates :title, :description, :location_id, :user_id, :categories, :days, :rule, :expiry, presence: true

  after_create :cascade_creation
  # the name method is an alias used
  # by the page title helper
  def name
    title
  end

  # using rule, create events for this series
  def cascade_creation
    # between start date and end date
    # if weekly: for each matching day, create and increment one week until we get to the expiry date
    # if not: for each matching day, find first or last in each month until we get to the expiry date
  end
end
