class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :events
  has_and_belongs_to_many :categories
  has_attached_file :picture, styles: { original: '500x500>', thumb: '100x100>'}, default_url: 'images/:st'
  validates :title, :description, :location_id, :user_id, :categories, 
  :days, :rule, :start_date, :start_time, :end_time, :expiry, presence: true

  after_create :cascade_creation, if: :persisted?
  after_update :cascade_update
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

  def cascade_update
    events.all.each do |event|
      event.update(event_attributes)
    end
  end

  # using rule, create events for this series
  def cascade_creation
    if rule == 'weekly'
      (start_date..expiry).each do |date|
        date_name = Date::DAYNAMES[date.wday]
        if day_array.include? (date_name)
          # create an event on this date
          child = Event.from_date_and_times(date, start_time, end_time, event_attributes)
          unless child.save
            logger.error "event could not be saved with rule #{rule} and date #{day_as_date}" 
          end
        end
      end
    else
      # for each month, get the matching dates for each day specified using the rule specified
      (start_date.month..expiry.month).each do |date|
        cur_month = Date::MONTHNAMES[date]
        day_array.each do |day|
          # day_as_date will be nil if Chronic can't parse it
          day_as_date = convert_rule_to_date(rule, day, cur_month)
          # don't accept any dates prior to today or after expiry
          unless day_as_date.nil? || day_as_date < DateTime.now.to_date || day_as_date > expiry
            child = Event.from_date_and_times(day_as_date, start_time, end_time, event_attributes)  
            unless child.save
              logger.error "event could not be saved with rule #{rule} and date #{day_as_date}" 
            end
          end
        end
      end
    end
  end

  private

  # Use Chronic to convert the rules to Date objects
  # in the case of the 'last' rule, we need to try the fifth followed by the fourth
  # if no date is found, it will return nil
  def convert_rule_to_date(rule, day, month)
    if %w{first second third}.include? rule
      Chronic.parse("#{rule} #{day} in #{month}")
    elsif rule == 'last'
      Chronic.parse("fifth #{day} in #{month}") || Chronic.parse("fourth #{day} in #{month}")
    end  
  end

  def event_attributes
    attributes.except('id', 'expiry', 'days', 'rule', 'start_date', 'start_time', 'end_time')
    .merge(event_series_id: self.id, categories: categories)
  end
end
