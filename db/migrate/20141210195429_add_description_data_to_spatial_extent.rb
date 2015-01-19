# ActiveRecord::Base.establish_connection :geographic

class AddDescriptionDataToSpatialExtent < ActiveRecord::Migration
  def up
    SpatialExtent.find_by( title: "Census Block Groups"        ).update_attribute(:desc, "A Census Block Group is a geographical unit used by the United States Census Bureau which is between the Census Tract and the Census Block. It is the smallest geographical unit for which the bureau publishes sample data, i.e. data which is only collected from a fraction of all households. Typically, Block Groups have a population of 600 to 3,000 people. Source: Wikipedia"                                                                                                                                                             )
    SpatialExtent.find_by( title: "Census Blocks"              ).update_attribute(:desc, "A census block is the smallest geographic unit used by the United States Census Bureau for tabulation of 100-percent data (data collected from all houses, rather than a sample of houses). The number of blocks in the United States, including Puerto Rico, for the 2010 Census was 11,155,486. Source: Wikipedia"                                                                                                                                                                                                                               )
    SpatialExtent.find_by( title: "Census Tracts"              ).update_attribute(:desc, "A census tract, census area, or census district is a geographic region defined for the purpose of taking a census. Usually these coincide with the limits of cities, towns or other administrative areas and several tracts commonly exist within a county. Source: Wikipedia"                                                                                                                                                                                                                                                                     )
    SpatialExtent.find_by( title: "Community Sub-Type"         ).update_attribute(:desc, "Community Sub-Types help to classify the considerable variability within individual Community Types."                                                                                                                                                                                                                                                                                                                                                                                                                                              )
    SpatialExtent.find_by( title: "Community Type"             ).update_attribute(:desc, "In order to understand how regional trends will affect the region’s diverse communities over the coming decades, MetroFuture identified four basic community types. While each city and town is unique, communities within each type share important characteristics that will influence their development over the coming decades. The criteria used to define Community Types include land use and housing patterns, recent growth trends, and projected development patterns."                                                                  )
    SpatialExtent.find_by( title: "Counties"                   ).update_attribute(:desc, "A county is a geographical region of a country used for administrative or other purposes. A county usually, but not always, contains cities, towns, townships, villages, or other municipal corporations. Source: Wikipedia"                                                                                                                                                                                                                                                                                                                       )
    SpatialExtent.find_by( title: "Massachusetts"              ).update_attribute(:desc, "The entire Commonwealth of Massachusetts. Generally, smaller geographies aggregated to the state level."                                                                                                                                                                                                                                                                                                                                                                                                                                           )
    SpatialExtent.find_by( title: "MetroFuture"                ).update_attribute(:desc, "MAPC analyzes regional trends on a broader 164-municipality region used by the Boston MPO for transportation modeling. This scale of analysis provides a better understanding of the impacts of different growth patterns than the 101 municipalities of the MAPC region. Source: MetroFuture"                                                                                                                                                                                                                                                     )
    SpatialExtent.find_by( title: "Municipalities"             ).update_attribute(:desc, "Cities and towns."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 )
    SpatialExtent.find_by( title: "Regional Planning Agencies" ).update_attribute(:desc, "The twelve Massachusetts regional planning agencies are public organizations that encompass a multi-jurisdictional regional community. They are founded on, sustained by and directly tied to local and/or state government laws, agreements or other actions. A regional council serves the local governments and citizens in the region by dealing with issues and needs that cross city, town, county and even state boundaries through communication, planning, policymaking, coordination, advocacy and technical assistance. Source: APA-MA" )
    SpatialExtent.find_by( title: "RPA Regions"                ).update_attribute(:desc, "RPA Regions are aggregations of Regional Planning Agencies, based on geography. These are not official boundaries, but rather unofficial groupings of RPAs. For example, the \"Central Massachusetts\" RPA Region consists of the Central Massachusetts Regional Planning Commission (CMRPC) and the Montachusett Regional Planning Commission (MRPC)."                                                                                                                                                                                              )
    SpatialExtent.find_by( title: "School Districts"           ).update_attribute(:desc, "Special-purpose districts which serve to operate local public primary and secondary schools. Each district is an independent special-purpose government, or dependent school systems, under the guidelines of state government and local school boards. Source: Wikipedia"                                                                                                                                                                                                                                                                         )
    SpatialExtent.find_by( title: "Schools"                    ).update_attribute(:desc, "Point locations for every public primary and secondary school."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    )
    SpatialExtent.find_by( title: "Subregions"                 ).update_attribute(:desc, "The 101 municipalities served by MAPC are assigned to one of eight subregions, based primarily on proximity and community type. Municipalities in each subregion convene to address common issues and work on a scale larger than that of the individual city or town."                                                                                                                                                                                                                                                                            )
  end

  def down
    SpatialExtent.find_each {|e| e.update_attribute :desc, nil }
  end
end
