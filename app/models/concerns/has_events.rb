module HasEvents
  extend ActiveSupport::Concern
  included do
    has_many :events
  end

  def coming_events
    events.coming
  end

  def unpublished_events
    events.unpublished
  end
end