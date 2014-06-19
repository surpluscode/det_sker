module EventsHelper
  def format_datetime(dt)
    dt.strftime("%a d. %d %b %Y %H:%M")
  end

  def format_starttime(dt)
    dt.strftime('%H:%M')
  end

  def format_date(d)
    I18n.localize(d, format: :short)
    #d.strftime("%a d. %d %b %Y")
  end

  def event_cancelled?(event)
    if event.cancelled
      'cancelled'
    end
  end

  # Given an array of Category objects
  # return a string of their keys
  # separated by space
  def categories_as_string(categories, title = false)
    string = categories.map do |e|
      title ? e.key.titleize : e.key
    end
    string.join(' ')
  end

  def category_options
    DetSker::Application.config.possible_categories
  end

  def location_options
    DetSker::Application.config.possible_locations
  end
end
