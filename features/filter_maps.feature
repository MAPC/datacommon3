Feature: Filter maps

  @focus    
  Scenario: Filter maps by topic
    Given a map named "Poverty" with topic "Economy"
    And a map named "Population" with topic "Demographics"
    And I am on the map index page
    When I filter by topic for "Economy"
    Then I should see a map named "Poverty"
    And I should not see a map named "Population"


  Scenario: Filter for a map by data source
    Given a map named "Poverty" with data source "ACS"
    And a map named "Population" with data source "MASS GIS"
    And I am on the map index page
    When I filter by data source for "ACS"
    Then I should see a map named "Poverty"
    And I should not see a map named "Population"