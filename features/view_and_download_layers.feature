Feature: View and download layers and metadata

  Scenario: Select a layer
    Given many layers
    And I am on the homepage
    When I follow "Explore Data"
    And I follow "Layer Catalog"
    Then I should be on the layer index page
    And I should see pagination controls
    When I select a layer
    Then I should be on the layer show page


  Scenario Outline: Download a layer
    Given a layer named "Births" with tablename "births"
    When I follow "Download Layer"
    And I follow "<link_format>"
    Then I get a download with the filename "<filename>"

    Examples:
      | link_format | filename       |
      | CSV         | births.csv     |
      | JSON        | births.json    |
      | GeoJSON     | births.geojson |
      | PostGIS SQL | births.sql     |
      | KML         | births.kml     |
      | Shapefile   | births.zip     |


  Scenario Outline: Download a layer
    Given a layer named "Poverty" with tablename "poverty_acs"
    When I follow "Download Metadata"
    And I follow "<link_format>"
    Then I get a download with the filename "<filename>"

    Examples:
      | link_format | filename                  |
      | CSV         | poverty_acs_metadata.csv  |
      | JSON        | poverty_acs_metadata.json |
      | XML         | poverty_acs_metadata.xml  |
      | YAML        | poverty_acs_metadata.yaml |
  