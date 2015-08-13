class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :events
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
      (start_date..expiry).each do |date|
        date_name = Date::DAYNAMES[date.wday]
        if day_array.include? (date_name)
          # create an event on this date
          child = Event.from_date_and_times(date, start_time, end_time, event_attributes)
          fail unless child.save
        end
      end
    elsif rule == 'first_week'
      # Run through all the months in question and use Chronic to parse the first 
      # date in that month for each relevant day
      (start_date.month..expiry.month).each do |date|
        cur_month = Date::MONTHNAMES[date]
        day_array.each do |day|
          first_day = Chronic.parse("first #{day} in #{cur_month}")
          unless first_day < DateTime.now.to_date
            child = Event.from_date_and_times(first_day, start_time, end_time, event_attributes)  
            fail unless child.save
          end
        end
      end
    elsif rule == 'last_week'
    end
    # if not: for each matching day, find first or last in each month until we get to the expiry date
  end

  def event_attributes
    attributes.except('id', 'expiry', 'days', 'rule', 'start_date', 'start_time', 'end_time')
    .merge(event_series_id: self.id, categories: categories)
  end
end
