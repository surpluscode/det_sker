xml.instruct!
xml.rss do
  xml.channel do
    xml.title @location.name
    xml.link location_url(@location)
    xml.description(@location.description)
    xml.docs 'http://cyber.law.harvard.edu/rss/rss.html'
    xml.ttl '30'

    @location.coming_events.each do |event|
      xml.item do
        xml.title event.title
        xml.link event_url(event)
        xml.guid event_url(event)
        xml.description event.short_description
        xml.pubDate event.created_at.rfc2822
        event.categories.each do |category|
          xml.category transl_cat(category)
        end
      end
    end
  end
end
