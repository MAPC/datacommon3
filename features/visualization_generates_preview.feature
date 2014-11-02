Feature: Saving visualization creates preview and thumbnail

  Scenario Outline:
    Given a <status> visualization named "<title>"
    When I edit the visualization
    And I click "Save"
    Then  I see the visualization edit page
    When I go to the visualization show page
    Then I see the new preview image
    When I go to the visualization index page
    And I go to the page with my visualization
    Then I see the new thumbnail image

  Examples:
    | status | title      |
    | new    | A New Vis  |
    | new    | An Old Vis |