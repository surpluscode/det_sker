class Event < ActiveRecord::Base
  validates :title, :description, :location, :start_time, :end_time, :category, :creator, presence: true

  # This method returns the index view
  # used by EventController to list all events
  # ordered by start-time
  # returns structure as follows:
  # {date1: [EventA, EventB], date2: [EventC, EventD]}
  def self.index
    events = self.order(:start_time)
    ordered_by_date = {}
    events.each do |event|
      start_date = event.start_time.to_date
      unless ordered_by_date.has_key? start_date
        ordered_by_date[start_date] = []
      end
      ordered_by_date[start_date] << event
    end
    ordered_by_date
  end
end
