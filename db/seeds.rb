# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

institutions = Institution.create([
  { 
    id: 1,
    short_name: "Metro Boston",
    long_name:  "Metropolitan Boston",
    subdomain:  "metroboston"
  },
  { 
    id: 2,
    short_name: "Central Mass",
    long_name:  "Central Massachusetts",
    subdomain:  "centralmass"
  }
])

brandings = Branding.create([
  { 
    id: 1,
    institution_id: 1,
    logo_url: 'logos/metro_boston_data_common.png',
    tagline: "A partnership between the Metropolitan Area Planning Council and the Boston Indicators Project at the Boston Foundation",
    map_gallery_intro: "Explore MAPC's Annual Report and Calendar maps, illustrating conditions in the region and see whether the map you want may already exist."
  },
  { 
    id: 2,
    institution_id: 2,
    logo_url: 'logos/central_mass_data_common.png',
    tagline: "A partnership between the Central Massachusetts Regional Planning Commission and the Worcester Indicators Project at the Worcester Foundation",
    map_gallery_intro: "Explore CMRPC's maps, illustrating conditions in the region and see whether the map you want may already exist."
  }
])

pages = Page.create([
  { id: 1,   institution_id: 1,  sort_order: 1,   topic_id: "about",      slug: "what-is-the-data-common"       },
  { id: 2,   institution_id: 1,  sort_order: 2,   topic_id: "about",      slug: "frequently-asked-questions"    },
  { id: 3,   institution_id: 1,  sort_order: 3,   topic_id: "about",      slug: "tools"                         },
  { id: 4,   institution_id: 1,  sort_order: 4,   topic_id: "about",      slug: "partners"                      },
  { id: 5,   institution_id: 1,  sort_order: 5,   topic_id: "about",      slug: "contact"                       },
  { id: 6,   institution_id: 1,  sort_order: 6,   topic_id: 'resources',  slug: "training-guides-and-tutorials" },
  { id: 7,   institution_id: 1,  sort_order: 7,   topic_id: 'resources',  slug: "data-resources"                },
  { id: 8,   institution_id: 1,  sort_order: 8,   topic_id: 'resources',  slug: "user-profiles"                 },
  { id: 9,   institution_id: 1,  sort_order: 9,   topic_id: 'community',  slug: "data-day-2009"                 },
  { id: 10,  institution_id: 1,  sort_order: 10,  topic_id: 'community',  slug: "data-day-2012"                 },
  { id: 11,  institution_id: 1,  sort_order: 11,  topic_id: 'community',  slug: "data-day-2013"                 },
  { id: 12,  institution_id: 2,  sort_order: 1,   topic_id: "about",      slug: "what-is-the-data-common"       },
  { id: 13,  institution_id: 2,  sort_order: 2,   topic_id: "about",      slug: "frequently-asked-questions"    },
  { id: 14,  institution_id: 2,  sort_order: 3,   topic_id: "about",      slug: "tools"                         },
  { id: 15,  institution_id: 2,  sort_order: 4,   topic_id: "about",      slug: "partners"                      },
  { id: 16,  institution_id: 2,  sort_order: 5,   topic_id: "about",      slug: "contact"                       },
  { id: 17,  institution_id: 2,  sort_order: 6,   topic_id: 'resources',  slug: "training-guides-and-tutorials" },
  { id: 18,  institution_id: 2,  sort_order: 7,   topic_id: 'resources',  slug: "data-resources"                },
  { id: 19,  institution_id: 2,  sort_order: 8,   topic_id: 'resources',  slug: "user-profiles"                 },
  { id: 20,  institution_id: 2,  sort_order: 9,   topic_id: 'community',  slug: "data-day-2009"                 },
  { id: 21,  institution_id: 2,  sort_order: 10,  topic_id: 'community',  slug: "data-day-2012"                 },
  { id: 22,  institution_id: 2,  sort_order: 11,  topic_id: 'community',  slug: "data-day-2013"                 }
])

layers = Layer.create([
    {
      id:          "ct10_id",
      title:       "Household Income by Age (Census Tracts)",
      alt_title:   " ",
      descriptn:   "AGE OF HOUSEHOLDER BY HOUSEHOLD INCOME IN THE PAST 12 MONTHS",
      subject:     "Economy",
      creator:     "American Community Survey",
      createdate:  " ",
      moddate:     "2013-12 (IN 2012 INFLATION-ADJUSTED DOLLARS)",
      publisher:   "MAPC",
      contributr:  " ",
      coverage:    "Statewide",
      universe:    "Households",
      schema:      "mapc",
      tablename:   "b19037_hh_income_by_age_acs_ct",
      tablenum:    "b19037",
      institution_id: 1
    },
    {
      id:         "bg10_id",
      title:      "Household Income by Age (Block Groups)",
      alt_title:  "",
      descriptn:  "AGE OF HOUSEHOLDER BY HOUSEHOLD INCOME IN THE PAST 12 MONTHS",
      subject:    "Economy",
      creator:    "American Community Survey",
      createdate: "",
      moddate:    "2013-12 (IN 2012 INFLATION-ADJUSTED DOLLARS)",
      publisher:  "MAPC",
      contributr: "",
      coverage:   "Statewide",
      universe:   "Households",
      schema:     "mapc",
      tablename:  "b19037_hh_income_by_age_acs_bg",
      tablenum:   "b19037",
      institution_id: 1
    },
    {
      id:         "Municipal ID",
      title:      "Households by Family Type, 2000,2010 (Municipal)",
      alt_title:  "",
      descriptn:  "",
      subject:    "Housing",
      creator:    "Census",
      createdate: "2000",
      moddate:    "2014-05",
      publisher:  "MAPC",
      contributr: "",
      coverage:   "Statewide, Municipalities and Counties",
      universe:   "Housing Units",
      schema:     "ds",
      tablename:  "hous_hh_fam_00_10m",
      tablenum:   "",
      institution_id: 2
    }
  ])



Visualization.find(1072).update_attribute(:featured, 4)
Visualization.find(23).update_attribute(  :featured, 5)
Visualization.find(27).update_attribute(  :featured, 6)
Visualization.find(2403).update_attribute(:featured, 2)
Visualization.find(2351).update_attribute(:featured, 3)
Visualization.find(2521).update_attribute(:featured, 1)


Hero.unscoped.where(active: false).limit(3).each do |h|
  h.update_attribute(:active, true)
  h.update_attribute(:institution_id, 2)
end


profiles = Profile.where(organization: 'CMRPC')
profiles = profiles + Profile.where(organization: 'Central Massachusetts Regional Planning Commission')

profiles.each do |profile|
  profile.user.visualizations.each {|v| v.update_attribute(:institution_id, 2)}
end

user  = User.where(username: 'cjryan2006').profile
user2 = User.where(username: 'mfranz77').profile
user3 = User.where(username: 'edd06001').profile
[user, user2, user3].each do |user|
  user.visualizations.each {|v| v.update_attribute(:institution_id, 2)}
end

Visualization.where(featured: nil).where(institution_id: 2).sample(3).each_with_index do |v, index|
  v.update_attribute(:featured, index)
end

Visualization.all.each do |v|
  query = <<-ESQL
    SELECT COUNT(*) 
    FROM core_genericobjectrolemapping
      WHERE role_id = 7 AND object_id = #{v.id}
  ESQL
  
  result = ActiveRecord::Base.connection.execute(query)
  count  = result.map {|r| r['count']}.first.to_i

  v.update_attribute(:permission, "public") if count == 2
end


Hero.create([
  {
    title: "Welcome to the Central Mass DataCommon",
    subtitle: "A Data Visualization Tool",
    content_markup_type: "html",
    content: "<p>The Central Mass DataCommon, a partnership between the Metropolitan Area Planning Council (MAPC), the Central Massachusetts Planning Commission, and Montachusetts Regional Planning Commission, provides a wealth of information about the region’s people and communities through a variety of topics -- from health care and education to economic development and transportation. DataCommon is an important resource for all those seeking to understand how the region is changing, it helps residents, stakeholders, planners, city and town officials, educators, the business community, journalists, and others explore data and make informed decisions. We invite you to explore its data, community snapshots and create your own visualizations and reports.</p>",
    _content_rendered: "<p>The Central Mass DataCommon, a partnership between the Metropolitan Area Planning Council (MAPC), the Central Massachusetts Planning Commission, and Montachusetts Regional Planning Commission, provides a wealth of information about the region’s people and communities through a variety of topics -- from health care and education to economic development and transportation. DataCommon is an important resource for all those seeking to understand how the region is changing, it helps residents, stakeholders, planners, city and town officials, educators, the business community, journalists, and others explore data and make informed decisions. We invite you to explore its data, community snapshots and create your own visualizations and reports.</p>",
    active: true,
    image: "http://upload.wikimedia.org/wikipedia/commons/f/fe/Worcester_Massachusetts.jpg",
    institution_id: 2
  },
  {
    title: "Help us improve the DataCommon!",
    subtitle: "User testing ongoing",
    content_markup_type: "html",
    content: "<p>The Central Mass DataCommon is currently in development. Help us ensure that this resource is easy for everyone to use! Our goal is to make it easy to find data, visualize it with a map or chart, and to use that visualization to communicate findings in a website, presentation, report, or email. We are looking for residents, stakeholders, planners, city and town officials, educators, the business community, journalists, and others — basically anyone who is interested in data to participate in usability testing. We are not testing you or your computer, but looking for ways to improve the data portal. Email <a href=\"mailto:cryan@cmrpc.org\">Chris Ryan, CMRPC</a>, for more information and to sign up.</p>",
    _content_rendered: "<p>The Central Mass DataCommon is currently in development. Help us ensure that this resource is easy for everyone to use! Our goal is to make it easy to find data, visualize it with a map or chart, and to use that visualization to communicate findings in a website, presentation, report, or email. We are looking for residents, stakeholders, planners, city and town officials, educators, the business community, journalists, and others — basically anyone who is interested in data to participate in usability testing. We are not testing you or your computer, but looking for ways to improve the data portal. Email <a href=\"mailto:cryan@cmrpc.org\">Chris Ryan, CMRPC</a>, for more information and to sign up.</p>",
    active: true,
    image: "http://upload.wikimedia.org/wikipedia/commons/c/c7/Union_Station,_Worcester_MA.jpg",
    institution_id: 2
  },
  {
    title: "New Data! 2013 Municipal Unemployment Rates",
    subtitle: "Unemployment data available for 1990-2013",
    content_markup_type: "html",
    content: "<p>The Massachusetts unemployment rate has decline over the past few years, but not everywhere in the state. The Bureau of Labor Statistics recently released the 2013 Local Area Unemployment Statistics and it is now available on the DataCommon. The DataCommon now has unemployment data for 1990-2013. Find out how Central Massachusetts and your municipality are doing.</p>",
    _content_rendered: "<p>The Massachusetts unemployment rate has decline over the past few years, but not everywhere in the state. The Bureau of Labor Statistics recently released the 2013 Local Area Unemployment Statistics and it is now available on the DataCommon. The DataCommon now has unemployment data for 1990-2013. Find out how Central Massachusetts and your municipality are doing.</p>",
    active: true,
    image: "http://upload.wikimedia.org/wikipedia/commons/c/c6/Greendale_Mall,_Worcester_MA.jpg",
    institution_id: 2
  }
])


StaticMap.create([
{
  id: 111,
  year: 2014,
  title: "CMRPC Region: Functional Road Classification",
  abstract: """Roadway functional classification map. MassDOT defines functional classification in the following three general categories:

  Arterials: Arterials provide the highest level of mobility at the greatest vehicular speed for the longest uninterrupted distances and are not intended to provide access to specific locations. Arterials are further subdivided into Principal Arterials and Minor Arterials. Interstates are considered to be arterials but are given their own category.
   
  Collectors: Collectors provide some level of both mobility and access. They collect traffic from local roads and funnel it to arterials. In rural areas, collectors are further subdivided into Major Collectors and Minor Collectors.
   
  Local roads: Local roads provide access to abutting land with little or no emphasis on mobility. The term \"local road\" should not be confused with local jurisdiction. Most, though not all, functionally classified local roads are under city or town jurisdiction.
   
  This map does not include \"local roads\" for readability.""",
  pdf_page: 'calendar/CMRPC_FC_Final.pdf',
  thumbnail: 'calendar/road-map-thumb.png',
  month: 9,
  institution_id: 2
},
{
  id: 112,
  year: 2005,
  title: "CMRPC Region Land Use Map",
  abstract: "Using data from MassGIS, CMRPC developed a 2005 regional land use map showing land use categories including residential, commercial, open land, water, and others. This maps shows where concentrations of developed land are location in relation to undeveloped lands such as wetlands, forests as well as transportation facilities.",
  pdf_page: 'calendar/CMRPC_2005LandUse_11x17.pdf',
  thumbnail: 'calendar/land-use-thumb.png',
  month: 1,
  institution_id: 2
}])


# THIS BLOCK IS TO ASSIGN MUNIS TO INSTITUTIONS
# AND GIVE SAMPLE CONTENT

ms = [17,21,28,32,39,45,54,77,80,84,110,124,134,138,151,179,186,188,202,212,215,216,222,226,228,241,257,271,278,280,287,290,303,304,311,316,321,323,328,348,11,12,15,19,64,97,103,115,125,140,147,153,162,234,235,255,270,282,294,299,332,343]


ms.each do |id|
  begin
    m = Municipality.find_by(unitid: id.to_s)
    m.update_attribute(:institution_id, 2)
  rescue
  end
end


samples = [
  "Maybe accessory use bike share gentrification. Open space retail topology homeless gentrification if regional planning children and families brownfield building code warped parallel wetland fragmented parallel. Groceries the riverwalk, schools pay and display retail compass school signalized intersection rural planning food shed but commute shed facilitate. Green house gas reduction strategy legislative gridiron, high speed rail implementation planner attract investment. Gentrification commercial market study public square developed world.",
  "Food shed household density suburb retail sales tax. Urban planning commercial corridor Robert Moses homeless ordinance level of service. Brownfield metropolitan planning organization city council rural planning facilities planning federal housing administration. Skyscrapers layer federal highway administration, prioritize value capture auction amortization environmental impact statement 35% of area median income redevelopment agencies sprawl city council housing element planning department.",
  "Plan government code toll plaza parks mixed use transportation finance, parklet curb cut fiscalization of land use fragmented parallel children and families parking ratio compatible uses sustainable communities strategy. Urbanized area green farmland of statewide importance, layer territorial expansion red curb transit 35% of area median income employment shed sustainable communities strategy unit plan market study congestion management water food security.",
  "Schools metropolitan planning organization signal commercial, feedback net operating income green house gas reduction strategy curb cuts water table local control building code origination fee in either. Fiscal impact analysis water table new urbanism implementation toll booth, rural Abu Dhabi water Le Corbusier. Building masses level of service bicycle, equity sharrows parallel parking block group tricycle unmarked crosswalk the sewer.",
  "Walk shed Levittown urban planning, vacancy layer sidewalk equestrian statues children and families minimum parking ratio Le Corbusier plan public works department public health. Disadvantaged unincorporated community block level streetscape improvement, urban planning feedback transportation finance rural broadband community engagement government code farmland of statewide importance unique farmland placard abuse community garden."
]

munis = Municipality.where(institution_id: 2)

munis.each do |m|
  m.short_desc = m._short_desc_rendered = samples.sample
  m.save
end

# END BLOCK


cmrpc_vis = [2660,2652,2639,2623,2526,2667,2674,2675,66,2550,2527,2664,2666,2671,2672,2676,2663,2662,2646,2681,2677,2658,2678,2679,2680]

Visualization.unscoped.find(cmrpc_vis).each {|v| v.update_attributes(institution_id: 2, permission: 'public')}




