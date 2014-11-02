Feature: View and download static maps

  Scenario: View map gallery
    Given I am on the homepage
    When I click "Explore Data"
    And I follow "Map Gallery"
    Then I am on the map index page
    And I see the header "Map Gallery"

  Scenario: View map details
    Given a map named "Land Use Map"
    When I follow "Land Use Map"
    Then I see the header "Land Use Map" 
    And I see "Map Details"

  Scenario: Download a map
    Given a map named "Land Use Map" with filename "land_use_map.pdf"
    And I am on the show page for the map
    When I click "Download Map"
    Then I should receive a downlaod with the filename "land_use_map.pdf"
