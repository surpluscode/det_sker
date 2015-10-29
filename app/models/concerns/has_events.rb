module HasEvents
  extend ActiveSupport::Concern
  included do
    has_many :events
  end

  def coming_events
    events.where('end_time > ?', DateTime.now).order(:start_time)
  end
end