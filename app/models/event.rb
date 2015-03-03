class Event < ActiveRecord::Base
  validates :title, :short_description, :start_time, :end_time, :location_id, :user_id, :category_id, presence: true

  belongs_to :user
  belongs_to :location
  belongs_to :categories
  has_many :comments
  has_attached_file :picture, styles: { original: '500x500>', thumb: '100x100>'}, default_url: 'images/:st'

  validates_attachment_content_type :picture, :content_type => /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, attributes: :picture, less_than:  1.megabytes

  def in_progress?
    start_time < DateTime.now && end_time > DateTime.now
  end

  def <=>(other)
    start_time <=> other.start_time
  end

  # the name method is an alias used
  # by the page title helper
  def name
    title
  end

  def self.current_events
    self.includes(:user, :location, :comments).order(:start_time).where('end_time > ?', DateTime.now)
  end

end
