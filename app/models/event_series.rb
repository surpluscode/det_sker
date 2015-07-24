class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_and_belongs_to_many :categories
  has_attached_file :picture, styles: { original: '500x500>', thumb: '100x100>'}, default_url: 'images/:st'
  validates :title, :description, :location_id, :user_id, :categories, presence: true

  # the name method is an alias used
  # by the page title helper
  def name
    title
  end
end
