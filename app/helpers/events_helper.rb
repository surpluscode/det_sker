module EventsHelper
  # included to fix bug in content_tag generation
  include ActionView::Context
  # necessary as events.js.erb will call this
  # Helper during precompile
  include ActionView::Helpers::FormHelper

  def format_datetime(dt)
    I18n.localize(dt, format: :calendar)
  end

  def format_starttime(dt)
    dt.strftime('%H:%M')
  end

  def format_date(d)
    I18n.localize(d, format: :header)
  end

  def title_display(event)
    if event.cancelled?
      "<s>#{event.title}</s> - <span class='text-danger'>#{I18n.t('events.event.cancelled')}</span>".html_safe
    else
      event.title
    end
  end

  def translated_category_name(cat_id)
    Category.find(cat_id).send(t(:language)).titleize
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
  def bootstrap_glyphicon(icon)
    content_tag(:span, nil, class: "glyphicon glyphicon-#{icon}").html_safe
  end
end
