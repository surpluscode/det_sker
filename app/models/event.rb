class Event < ActiveRecord::Base
  validates :title, :short_description, :location, :start_time, :end_time, :user_id, presence: true
  validates_inclusion_of :location, in: DetSker::Application.config.possible_locations
  belongs_to :user


  # This method returns the index view
  # used by EventController to list all events
  # ordered by start-time
  # returns structure as follows:
  # {date1: [EventA, EventB], date2: [EventC, EventD]}
  def self.index
    events = self.joins(:user).order(:start_time).where('end_time > ?', DateTime.now)
    ordered_by_date = {}
    ordered_by_date[:in_progress] = []
    events.each do |event|
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

  # Return a hash containing event categories
  # with their counts as values
  def self.categories
    Event.select(:category)
    .where('end_time > ?', DateTime.now)
    .group(:category)
    .order('count_category desc').count
  end
end
