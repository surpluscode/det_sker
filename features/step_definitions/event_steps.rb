When(/^a user visits the home page$/) do
  visit root_path
end
Given (/^an event with title "(.*)" and description "(.*)" has been created$/) do |title, description|
  @event_details = { title: title,
                    creator: 'FestAbe99',
                    description: description,
                    location: 'ungdomshuset',
                    start_time: DateTime.new,
                    end_time: DateTime.new,
                    category: 'party' }
  Event.create(@event_details)
end

Then(/^they should see events$/) do
  page.has_selector?('.event-container')
end

And(/^the text "(.*)" should be visible$/) do |text|
  page.has_text?(text, visible: true)
end

But(/^the text "(.*)" should be hidden$/) do |text|
  page.has_text?(text, visible: false)
end