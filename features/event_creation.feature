Feature: Event creation
  Users should be able to create events

  Scenario: The application allows users to create events
    Given I am a logged in user
    And the category 'party' exists
    When a user visits the home page
    And I click on the New Event link
    Then the form "new_event" should be visible
    When I fill in the form
    Then the text "Event was created successfully" should be visible