class EventContainer
  include Enumerable
  attr_accessor :events, :title

  def initialize
    @events = []
  end

  def add_event(event)
    @events << event
  end

  def each(&block)
    @events.each {|event| block.call(event)}
  end

  def size
    @events.size
  end

end