class Calendar

  attr_reader :categories

  def initialize(type = :coming)
    @days = {}
    @categories = {}
    if type == :coming
      get_coming_events
      get_coming_categories
    end
  end

  # Convert the Active Relation returned from
  # the categories query into a hash containing
  # category keys and number of occurrences
  def get_coming_categories
    Category.current_categories.each do |cat|
     @categories.store(cat['key'].to_sym, cat['num'])
    end
  end

  # Based on the dates of the events given
  # by the current_events method, sort them into
  # Day objects. If an event date is already present,
  # add it to the events for that day. Otherwise,
  # create a new Day object
  def get_coming_events
    Event.current_events.each do |e|
      start_date = e.start_time.to_date
      if @days.has_key? start_date
        @days[start_date].add_event(e)
      else
        d = Day.new(e)
        @days.store(d.date, d)
      end
    end
    self
  end

  # Accessor method - convert the days hash we use
  # internally into an array of day objects
  # sorted asc
  def days
    @days.values.sort {|x,y| x.date <=> y.date}
  end


end