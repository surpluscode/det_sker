class Day < EventContainer
  attr_reader :date

  # Given an event object
  # we create an array of event objects
  # containing this object and use its
  # date as the date for this day
  def initialize(event)
    @events = [event]
    @date = event.start_time.to_date
  end

  # Add an event to the event array
  # if it has the correct date, otherwise
  # throw an Exception
  def add_event(event)
    if event.start_time.to_date == @date
      super(event)
    else raise 'Event supplied'
    end
  end

  def <=>(other)
    @date <=> other.date
  end

end