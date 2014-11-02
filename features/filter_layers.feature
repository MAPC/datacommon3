Feature: Filter layers

  Scenario: Filter layers by topic
    Given an issue area "Economy" with a layer named "Poverty"
    And an issue area "Demographics" with a layer named "Population"
    And I am on the layer index page
    When I filter by topic for "Economy"
    Then I see "Poverty"
    And I do not see "Population"


  Scenario: Filter for a layer by data source
    Given a layer named "Poverty" with data source "ACS"
    And a layer named "Population" with data source "MASS GIS"
    And I am on the layer index page
    When I filter by data source for "ACS"
    Then I see "Poverty"
    And I do not see "Population"