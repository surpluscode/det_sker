module EventsHelper
  # included to fix bug in content_tag generation
  include ActionView::Context
  # necessary as events.js.erb will call this
  # Helper during precompile
  include ActionView::Helpers::FormHelper

  def format_datetime(dt)
    I18n.localize(dt, format: :calendar)
  end

  def format_daterange(starttime, endtime)
    # If it's the same day, only print day once
    if starttime.to_date == endtime.to_date
      "#{I18n.localize(starttime, format: :calendar)} - #{I18n.localize(endtime, format: :time)}"
    else
      "#{I18n.localize(starttime, format: :calendar)} - #{I18n.localize(endtime, format: :calendar)}"
    end
  end


  def format_starttime(dt)
    dt.strftime('%H:%M')
  end

  def format_date(d)
    I18n.localize(d, format: :header)
  end

  def rss_description(event)
    description = ''
    description << event.location.display_name
    description <<  ', '
    description << format_datetime(event.start_time)
    description <<  "\n"
    description << simple_format(event.short_description)
  end

  def rss_image_attrs(event)
    {
        url: image_url(event.picture_url),
        title: event.title,
        alt: event.title,
        type: event.picture_content_type
    }
  end

  def title_display(event)
    if event.cancelled?
      "<s>#{event.title}</s> - <span class='text-danger'>#{I18n.t('events.event.cancelled')}</span>".html_safe
    else
      event.title
    end
  end

  def categories_as_string(categories, title = false)
    categories.map { |cat| transl_cat(cat) }.join(' ')
  end

  # Return the current language string for a category
  # @param cat Category | String (id)
  def transl_cat(cat)
    cat = Category.find(cat) unless cat.is_a? Category
    cat.send(t :language).titleize
  rescue
    ''
  end

  def render_filter_link(id, name, total, type)
    link_to "#{name} (#{total})", '',
            data: { toggle: id, filter_type: type,
                    role: 'filter-link'
            }
  end
  def display_repetition_rule(series)
    # translate the days and convert them to a string
    transl_days = series.day_array.collect { |d| I18n.t("day_names.#{d.titleize}", default: d) }.to_sentence(locale: I18n.locale)
    if series.rule == 'weekly'
      I18n.t('event_series.weekly_display_rule', days: transl_days)
    else
      transl_rule = I18n.t("event_series.#{series.rule}", default: series.rule)
      I18n.t('event_series.monthly_display_rule', days: transl_days, rule: transl_rule)
    end
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

  def dayname_collection
    names = Date::DAYNAMES.dup
    names << names.delete_at(0) # move sunday to the end!
    names.collect {|n| [t("day_names.#{n}"), n]}
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

  def typeahead_header(text = '_value_')
    content_tag(:div) do
      content_tag :strong, class: 'use-styles' do
        text
      end
    end
  end

  def typeahead_element(text = '_value_')
    content_tag(:div) do
      content_tag(:span, class: 'use-styles') do
        text
      end
    end
  end

  # Generic method to create glyphicon icons
  # supply only the last component of the icon name
  # e.g. 'off', 'cog' etc
  def bootstrap_glyphicon(icon, classes = '')
    html_class = ['glyphicon', "glyphicon-#{icon}", classes].select(&:present?).join(' ')
    content_tag(:span, nil, class: html_class, 'aria-hidden': true).html_safe
  end

  def bootstrap_success(message)
    bootstrap_alert(message, 'success')
  end

  def bootstrap_danger(message)
    bootstrap_alert(message, 'danger')
  end

  def bootstrap_info(message)
    bootstrap_alert(message, 'info')
  end

  def bootstrap_alert(message, level)
    content_tag(:div, message.html_safe, class: "alert alert-#{level}", role: 'alert')
  end

  # return json ld of object schema microdata
  def schema_json(object)
    details = object.to_schema
    case object
     when Event
      url = event_url(object)
      # we add the picture url here so that we can create a url
      details.merge!(image: image_url(object.best_picture.url(:original))) if object.best_picture.present?
      when User
        return if object.is_anonymous?
        url = user_url(object)
      when Location
        url = location_url(object)
      else
        return
    end
    details.merge!(url: url)
    content_tag(:script, details.to_json.html_safe, type: 'application/ld+json')
  end

  def image_url(file)
    request.protocol + request.host_with_port + file
  end
end