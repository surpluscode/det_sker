Feature: The index page
  In order to discover events
  The users
  Should be able to see events

Scenario: The application has an index page
  Given an event with title "Sample event" and description "Sample description" has been created
  When a user visits the home page
  Then the text "Sample event" should be visible
  But the text "Sample description" should be hidden