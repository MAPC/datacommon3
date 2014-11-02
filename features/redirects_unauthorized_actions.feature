Feature: Redirects unauthorized actions


  Scenario: User attempts unauthorized edit to profile
    Given a user with username "planner" and password "secret"
    And I am signed out
    When I try to edit the profile for user "planner"
    Then I should be on the new user session page
    And I should see "only the user"


  Scenario: User attempts to view private visualization
    Given a user with username "planner" and password "secret"
    And a private visualization
    When I try to view the private visualization
    Then I should be on the new user session page
    And I should see "only the owner"


  Scenario: User attempts unauthorized edit to visualization
    Given a user with username "planner" and password "secret"
    And a someone else's public visualization
    When I try to view the public visualization
    Then I should be on the new user session page
    And I should see "only the owner"