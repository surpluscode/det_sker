class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  has_many :events
  has_and_belongs_to_many :categories
  validates :title, :description, :location_id, :user_id, :categories, 
  :day_array, :rule, :start_date, :start_time, :end_time, :expiry, presence: true
  
  # TODO: this duplicates functionality in Event.rb so it should be refactored, but modularization caused constant load errors 
  has_attached_file :picture, styles: { original: '500x500>', thumb: '100x100>'}, default_url: 'images/:st'
  validates_attachment_content_type :picture, :content_type => /\Aimage/
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, attributes: :picture, less_than:  1.megabytes

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

  def coming_events
    self.events.where('start_time > ? ', DateTime.now.to_formatted_s(:db))
  end

  # 1. update all existing events
  # 2. create new events - starting from the last existing event and ending at expiry
  def cascade_update
    coming_events.all.each do |event|
      # We retain the existing date but update to reflect any changes to start time or end time
      start_time = DateTime.new(event.start_time.year, event.start_time.month, event.start_time.day, self.start_time.hour, self.start_time.min, 0, self.start_time.zone)
      end_time = DateTime.new(event.end_time.year, event.end_time.month, event.end_time.day, self.end_time.hour, self.end_time.min, 0, self.end_time.zone)
      event.update(event_attributes.merge(start_time: start_time, end_time: end_time))
    end
    date_last_existing = coming_events.order(:start_time).last.start_time.to_date
    create_events(date_last_existing, expiry)
  end
  
  # using rule, create events for this series
  def create_events(start_d, expiry_d)
     if rule == 'weekly'
      (start_d..expiry_d).each do |date|
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
      dates_to_months(start_d, expiry_d).each do |month|
        cur_month = Date::MONTHNAMES[month]
        day_array.each do |day|
          # day_as_date will be nil if Chronic can't parse it
          day_as_date = convert_rule_to_date(rule, day, cur_month)
          # don't accept any dates prior to today or after expiry_d
          unless day_as_date.nil? || day_as_date < DateTime.now.to_date || day_as_date > expiry_d
            child = Event.from_date_and_times(day_as_date, start_time, end_time, event_attributes)  
            unless child.save
              logger.error "event could not be saved with rule #{rule} and date #{day_as_date}" 
            end
          end
        end
      end
    end
  end

  # get the month numbers for the dates in question
  # e.g. from Date1 to Date2 -> [10,11,12,1] 
  def dates_to_months(date1, date2)
    (date1..date2).to_a.collect(&:month).uniq  
  end

  def cascade_creation
    create_events(start_date, expiry) 
  end

  def short_description=(val)
    self.description = val
  end

  # Returns the series objects with
  # weekly events occurring this week
  def self.active_weekly
    self.where('start_date <= ?', DateTime.now)
        .where('expiry >= ?', DateTime.now)
      .includes(:categories)
      .includes(:location)
      .where("rule LIKE 'weekly'")
      .order('categories.danish desc')
  end

  def self.repeating_by_day
    days = Date::DAYS_INTO_WEEK.transform_values { |_| [] } # create hash in style { :dayname => [] }
    self.active_weekly.each do |series|
      series.days.split(',').each do |day|
        days[day.downcase.to_sym] << series if days.has_key?(day.downcase.to_sym)
      end
    end
    days
  end

  private

  # Use Chronic to convert the rules to Date objects
  # in the case of the 'last' rule, we need to try the fifth followed by the fourth
  # if no date is found, it will return nil
  def convert_rule_to_date(rule, day, month)
    Rails.logger.info "CHRONIC:: #{rule} #{day} in #{month}"
    if %w{first second third}.include? rule
      Chronic.parse("#{rule} #{day} in #{month}")
    elsif rule == 'last'
      Chronic.parse("fifth #{day} in #{month}") || Chronic.parse("fourth #{day} in #{month}")
    end  
  end

  def event_attributes
    attributes.except(
      'id', 'expiry', 'days', 'rule', 'start_date', 'start_time', 'end_time', 
      'picture_file_size', 'picture_content_type', 'picture_updated_at', 'picture_file_name'
    ).merge(event_series_id: self.id, categories: categories)
  end
end
