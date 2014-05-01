When(/^a user visits the home page$/) do
  visit root_path
end

Then(/^they should see events$/) do
  page.has_selector?('.event-container')
end

And(/^they should see event descriptions$/) do
  page.has_selector?('event-description')
end

But(/^event details should be hidden$/) do
  page.has_selector?('.event-details', visible: false)
end