When(/^a user visits the home page$/) do
  visit root_path
end

Then(/^they should see events$/) do
  page.has_selector?('.event-container')
  page.has_selector?('.event-details')
end