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
      title ? e.key.titleize : e.key.parameterize('_')
    end
    string.join(' ')
  end

  # This function is to be shared between html and js views
  # In the case of js views, we can't pass the variables, therefore
  # we give a default value which can be overwritten.
  def bootstrap_label(id = '<id>', value = '<value>')
    # we create the content in two steps to make the nested value
    # output correctly
    content = value
    content << content_tag(:a, id: "remove_#{id}") do
      content_tag(:span, '', class: 'remove glyphicon glyphicon-remove glyphicon-white')
    end

    content_tag(:span, id: "label_#{id}", class: 'tag label label-primary') do
      content.html_safe
    end
  end
end
