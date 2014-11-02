Feature: User Authentication

  Scenario Outline: User logs in.
    Given a user with username "<username>" and password "secret"
    And an institution
    When I sign in manually as "<username>" with password "secret"
    Then I am on the institution page
    And I see "<header>"

    Examples:
      | username | profile_name | header      |
      | planner  |              | Hi, planner |
      | planner  | Jane         | Hi, Jane    |

  
  Scenario: User logs out.
    Given I am signed in
    When I click on my name in the header
    And I follow "Log out"
    Then I am on the institution page
    And I do not see "Hi, "


  Scenario: Signed in user tries to log in.
    Given I am signed in
    When I navigate to the login page
    Then I am redirected away from the login page
    And I am on the home page
    And I see "already"