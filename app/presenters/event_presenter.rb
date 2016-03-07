class EventPresenter

  attr_reader :object

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end

  def description
    @object.short_description
  end

  def fb_tags
    tags = []
    tags << fb_url
    tags << fb_type
    tags << fb_title
    tags << fb_description
    tags << fb_image
    tags << fb_site_name
    tags << fb_locale
    tags.join("\n").html_safe
  end

  def fb_url
    fb_tag('url', event_url(@object))
  end

  # There doesn't seem to be a better Open Graph type for events
  # See https://developers.facebook.com/docs/reference/opengraph#object-type
  def fb_type
    fb_tag('type', 'article')
  end

  def fb_title
    fb_tag('title', @object.title)
  end

  def fb_description
    shortened_description = description.split('. ').take(4).join('. ')
    fb_tag('description', shortened_description)
  end

  def fb_site_name
    fb_tag('site_name', I18n.t(:app_name))
  end

  # We're hardcoding to a Danish locale here because most of the content
  # is in Danish even if the interface is in English
  def fb_locale
    fb_tag('locale', 'da_DK')
  end

  def fb_image
    if @object.best_picture.present?
      fb_tag('image', asset_url(@object.best_picture.url(:original)))
    else
      ''
    end
  end

  def fb_tag(type, content)
    tag 'meta', { property: "og:#{type}", content: content }, true
  end

  private

  # This forwards undefined methods to
  # the view context, e.g. link_to etc
  def method_missing(*args, &block)
    @view_context.send(*args, &block)
  end
end