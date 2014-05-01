When(/^a user visits the home page$/) do
  visit root_path
end

Then(/^they should see events$/) do
  page.has_selector?('.event-container')
end

And(/^(.*) should be visible$/) do |classname|
  page.has_selector?(convert_to_selector(classname), visible: true)
end

But(/^(.*) should be hidden$/) do |classname|
  page.has_selector?(convert_to_selector(classname), visible: false)
end

def convert_to_selector(text)
  '.' + text.gsub(' ', '-')
end