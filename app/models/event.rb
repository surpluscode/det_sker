class Event < ActiveRecord::Base
  validates :title, :short_description, :start_time, :end_time, :location_id, :user_id, presence: true

  belongs_to :user
  belongs_to :location
  has_and_belongs_to_many :categories
  has_many :comments


  # This method returns the index view
  # used by EventController to list all events
  # ordered by start-time
  # returns structure as follows:
  # {date1: [EventA, EventB], date2: [EventC, EventD]}
  def self.index
    ordered_by_date = {}
    ordered_by_date[:in_progress] = []
    current_events.each do |event|
      # skip finished events
      next if event.end_time < DateTime.now
      # pull all the current events out into their own section
      if (event.start_time < DateTime.now) && (event.end_time > DateTime.now)
        ordered_by_date[:in_progress] << event
        next
      end
      # all other events are grouped by their date
      start_date = event.start_time.to_date
      unless ordered_by_date.has_key? start_date
        ordered_by_date[start_date] = []
      end
      ordered_by_date[start_date] << event
    end
    ordered_by_date
  end

  def self.current_events
    self.includes(:user, :location).order(:start_time).where('end_time > ?', DateTime.now)
  end

end
