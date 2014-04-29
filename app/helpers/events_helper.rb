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

  def category_options
    [['Fest / Koncert', :party], ['Demo / Action', :demo],
     ['Talk / Seminar / Workshop', :education], ['Meeting', :meeting], ['Folkekøkken', :food], ['Andet', :other]]
  end
end
