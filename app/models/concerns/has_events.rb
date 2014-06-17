module HasEvents
  extend ActiveSupport::Concern
  included do
    has_many :events
  end

  def coming_events
    events.where('end_time > ?', DateTime.now)
  end
end