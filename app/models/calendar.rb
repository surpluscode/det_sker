class Calendar

  def initialize(type = :coming)
    @days = {}
    @dates = []
    if type == :coming
      get_coming_events
    end
  end

  def get_coming_events
    events = Event.current_events
    events.each do |e|
      start_date = e.start_time.to_date
      puts "start_date is #{start_date}"
      if @days.has_key? start_date
        @days[start_date].add_event(e)
      else
        d = Day.new(e)
        @days[d.date] = d
      end
    end
    self
  end

  # we only want to return the day objects
  # from this class sorted asc
  def days
    @days.values.sort {|x,y| x.date <=> y.date}
  end


end