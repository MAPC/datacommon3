Feature: Friendly forwarding on visualizations

  Scenario: User logs in to view private visualization
    Given a user with username "planner" and password "secret"
    And I have been redirected from my private visualization
    When I sign in manually as "planner" with password "secret"
    Then I should be on the private visualization page

  Scenario: User logs in to view private visualization
    Given a user with username "planner" and password "secret"
    And I have been redirected from my profile edit page
    When I sign in manually as "planner" with password "secret"
    Then I should be on my profile edit page