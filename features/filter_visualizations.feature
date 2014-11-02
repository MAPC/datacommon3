Feature: Filter visualizations

  Scenario: Filter visualizations by topic
    Given a visualization named "Poverty" with topic "Economy"
    And a visualization named "Population" with topic "Demographics"
    And I am on the visualization index page
    When I filter by topic for "Economy"
    Then I should see a visualization named "Poverty"
    And I should not see a visualization named "Population"


  Scenario: Filter for a visualization by data source
    Given a visualization named "Poverty" with data source "ACS"
    And a visualization named "Population" with data source "MASS GIS"
    And I am on the visualization index page
    When I filter by data source for "ACS"
    Then I should see a visualization named "Poverty"
    And I should not see a visualization named "Population"