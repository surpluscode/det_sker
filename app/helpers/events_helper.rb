module EventsHelper
  def format_datetime(dt)
    dt.strftime("%a d. %d %b %Y %H:%M")
  end

  def format_date(d)
    d.strftime("%a d. %d %b %Y")
  end

  def event_cancelled?(event)
    if event.cancelled
      'cancelled'
    end
  end
end
