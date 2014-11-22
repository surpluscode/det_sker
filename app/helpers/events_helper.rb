module EventsHelper
  # included to fix bug in content_tag generation
  include ActionView::Context
  # necessary as events.js.erb will call this
  # Helper during precompile
  include ActionView::Helpers::FormHelper

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

  # A category tag is composed of two elements
  # a hidden input field and a bootstrap label
  # The input is connected to the label via a
  # javascript listener, so that it will be removed
  # when the label is removed.
  # This function is to be shared between html and js views
  # In the case of js views, we can't pass the variables, therefore
  # we give a default value which can be overwritten.
  def category_tag(cat_id = '_id_', value = '_value_')
    bootstrap_label(cat_id, value) + category_input(cat_id)
  end

  def category_input(val)
    hidden_field_tag(val, val, name: 'event[category_ids][]', data: { role: 'category_value' } )
  end


  def bootstrap_label(id, value)
    # we create the content in two steps to make the nested value
    # output correctly
    content = value
    content << content_tag(:a, data: { function: 'remove_category', target: id }) do
      content_tag(:span, '', class: 'remove glyphicon glyphicon-remove glyphicon-white')
    end

    content_tag(:span, class: 'tag label label-primary') do
      content.html_safe
    end
  end
end
