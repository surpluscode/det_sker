xml.instruct!
xml.rss version: '2.0' do
  xml.channel do
    xml.title @user.name
    xml.link user_url(@user)
    xml.docs 'http://cyber.law.harvard.edu/rss/rss.html'
    xml.ttl '30'

    @calendar.events.each do |event|
      xml.item do
        xml.title title_display(event)
        xml.link event_url(event)
        xml.guid event_url(event)
        xml.description rss_description(event)
        xml.pubDate event.created_at.rfc2822
        xml.enclosure(rss_image_attrs(event)) if event.has_picture?
        event.categories.each do |category|
          xml.category transl_cat(category)
        end
      end
    end
  end
end
