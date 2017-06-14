module RssHelper
  # when external agents use the rss export with CMS clients,
  # they may need somewhat different formatting
  # see https://github.com/ronan-mch/det_sker/issues/365
  def rss_calendar_sort?
    params[:sort_by].present? && params[:sort_by] == 'calendar'
  end

  def rss_description(event)
    description = ''
    description << event.location.display_name
    unless rss_calendar_sort?
      description <<  ', '
      description << format_datetime(event.start_time)
    end
    description <<  "\n"
    description << simple_format(event.short_description)
  end

  def rss_pub_date(event)
    if rss_calendar_sort?
      event.start_time.rfc2822
    else
      event.created_at.rfc2822
    end
  end

  def rss_image_attrs(event)
    {
        url: image_url(event.picture_url),
        title: event.title,
        alt: event.title,
        type: event.picture_content_type
    }
  end
end