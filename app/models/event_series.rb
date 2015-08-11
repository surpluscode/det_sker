class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_and_belongs_to_many :categories
  has_attached_file :picture, styles: { original: '500x500>', thumb: '100x100>'}, default_url: 'images/:st'
  validates :title, :description, :location_id, :user_id, :categories, 
  :days, :rule, :start_date, :start_time, :end_time, :expiry, presence: true

  after_create :cascade_creation, if: :persisted?
  # the name method is an alias used
  # by the page title helper
  def name
    title
  end

  # We use these methods as proxies to the days field
  # so that we can store array data as strings and not
  # worry about SQL level compatibility issues.
  def day_array
    days.split(',') if days.present?
  end

  def day_array=(arr)
    self.days = arr.join(',')
  end

  # using rule, create events for this series
  def cascade_creation
    # between start date and end date
    #days_occurring = days.split(',')
    #TODO: these should use actual start date from form  
    if rule == 'weekly'
      (start_date..expiry.to_date).each do |date|
        if day_array.include? (Date::DAYNAMES[date.wday])
          # create an event on this date
          event_start = DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, start_time.sec, start_time.zone)
          event_end = DateTime.new(date.year, date.month, date.day, end_time.hour, end_time.min, end_time.sec, end_time.zone)
          child = Event.new(event_attributes.merge(start_time: event_start, end_time: event_end))  
          fail unless child.save
        end
      end
    else
    end
    # if not: for each matching day, find first or last in each month until we get to the expiry date
  end

  def event_attributes
    attributes.except('id', 'expiry', 'days', 'rule', 'start_date', 'start_time', 'end_time')
    .merge(event_series_id: self.id, categories: categories)
  end
end
