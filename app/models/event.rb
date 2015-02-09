class Event < ActiveRecord::Base
  validates :title, :short_description, :start_time, :end_time, :location_id, :user_id, presence: true

  belongs_to :user
  belongs_to :location
  has_and_belongs_to_many :categories
  has_many :comments
  has_attached_file :picture, styles: { medium: '300x300>', thumb: '100x100>'}, default_url: 'images/:st'

  validates_attachment_content_type :picture, :content_type => /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]
 # validates_attachment :picture,
  #                     content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }

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
