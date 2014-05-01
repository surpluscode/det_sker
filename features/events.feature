Feature: The index page
  In order to discover events
  The users
  Should be able to see events

Scenario: The application has an index page
  When a user visits the home page
  Then event title should be visible
  But event description should be hidden
  But event details should be hidden