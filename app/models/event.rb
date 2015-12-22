class Event < ActiveRecord::Base
  validates :title, :short_description, :start_time, :end_time, :location_id, :user_id, :categories, presence: true

  belongs_to :user
  belongs_to :location
  belongs_to :event_series
  has_and_belongs_to_many :categories
  has_many :comments
  has_attached_file :picture, styles: { original: '500x500>', thumb: '100x100>'}, default_url: 'images/:st'

  validates_attachment_content_type :picture, :content_type => /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, attributes: :picture, less_than:  3.megabytes

  def in_progress?
    start_time < DateTime.now && end_time > DateTime.now
  end

  def <=>(other)
    start_time <=> other.start_time
  end

  def description=(val)
    self.short_description = val
  end

  # the name method is an alias used
  # by the page title helper
  def name
    title
  end

  def best_picture
    if picture.present?
      picture
    elsif event_series.present? && event_series.picture.present?
      event_series.picture
    else
      nil
    end 
  end

  def weekly?
    event_series.present? && event_series.rule == 'weekly'
  end

  def self.current_events
    self.includes(:user, :location, :event_series)
        .order(:start_time)
        .where('events.end_time > ?', DateTime.now)
  end

  def self.current_non_weekly
    self.includes(:user, :location)
      .joins(:event_series)
      .where.not('event_series.rule': 'weekly')
      .order(:start_time)
      .where('events.end_time > ?', DateTime.now)
  end

  def self.current_non_repeating
    self.includes(:user, :location)
      .where('end_time > ?', DateTime.now)
      .where(event_series_id: nil)
      .order(:start_time)
  end

  def self.featured_events
    self.current_events.where(featured: true).limit(3)
  end

  def self.non_featured_events
    self.current_events
        .where.not(featured: true)
        .where('event_series_id IS NULL')
  end

  # Highlights is composed of num events where
  # these are composed of featured events and non-featured events
  def self.highlights(num)
    featured = self.featured_events
    if featured.size < num
      featured + self.non_featured_events.take(num - featured.size)
    else
      featured
    end
  end

  # The repeating events that are occurring this week
  def self.repeating_this_week
    self.select('id, event_series_id')
      .where('end_time > ?', DateTime.now)
      .where('start_time >= ?', DateTime.now)
      .where('start_time <= ?', DateTime.now + 1.week)
      .where('event_series_id > 0')
      .where('cancelled IS NULL OR cancelled = FALSE')
  end

  # Return Event object given a Date, Time, Time, attribute Hash
  def self.from_date_and_times(date, start_time, end_time, attributes)
    event_start = DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, 0, start_time.zone)
    event_end = DateTime.new(date.year, date.month, date.day, end_time.hour, end_time.min, 0, end_time.zone)
    Event.new(attributes.merge(start_time: event_start, end_time: event_end))  
  end

  def to_schema
    {
      '@context': 'http://schema.org', 
      '@type': 'Event',
      name: self.title, 
      startDate: self.start_time.iso8601, 
      endDate: self.end_time.iso8601, 
      description: self.short_description, 
      sameAs: self.link,
      location: self.location.to_schema,
      organizer: self.user.to_schema
    }
  end

end
