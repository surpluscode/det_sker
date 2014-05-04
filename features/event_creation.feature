Feature: Event creation
  Users should be able to create events

  Scenario: The application allows users to create events
    When a user visits the home page
    And they click on the New Event link
    Then the form "new_event" should be visible
    When they fill in the form
    Then the text "Sample title" should be visible