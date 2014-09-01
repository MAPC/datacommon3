# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# institutions = Institution.create([
#                 { 
#                   id: 1,
#                   short_name: "Metro Boston",
#                   long_name:  "Metropolitan Boston",
#                   subdomain:  "metroboston"
#                 },
#                 { 
#                   id: 2,
#                   short_name: "Central Mass",
#                   long_name:  "Central Massachusetts",
#                   subdomain:  "centralmass"
#                 }
#               ])

# brandings = Branding.create([
#     { 
#       id: 1,
#       institution_id: 1,
#       logo_url: 'logos/metro_boston_data_common.png',
#       tagline: "A partnership between the Metropolitan Area Planning Council and the Boston Indicators Project at the Boston Foundation",
#       map_gallery_intro: "Explore MAPC's Annual Report and Calendar maps, illustrating conditions in the region and see whether the map you want may already exist."
#     },
#     { 
#       id: 2,
#       institution_id: 2,
#       logo_url: 'logos/central_mass_data_common.png',
#       tagline: "A partnership between the Central Massachusetts Regional Planning Commission and the Worcester Indicators Project at the Worcester Foundation",
#       map_gallery_intro: "Explore CMRPC's maps, illustrating conditions in the region and see whether the map you want may already exist."
#     }
#   ])

# pages = Page.create([
#     {
#       id:              1,
#       institution_id:  1,
#       sort_order:      1,
#       topic_id:       "about",
#       slug:           "what-is-the-data-common"
#     },
#     {
#       id:              2,
#       institution_id:  1,
#       sort_order:      2,
#       topic_id:       "about",
#       slug:           "faq"
#     },
#     {
#       id:              3,
#       institution_id:  1,
#       sort_order:      3,
#       topic_id:       "about",
#       slug:           "tools"
#     },
#     {
#       id:              4,
#       institution_id:  1,
#       sort_order:      4,
#       topic_id:       "about",
#       slug:           "partners"
#     },
#     {
#       id:              5,
#       institution_id:  1,
#       sort_order:      5,
#       topic_id:       "about",
#       slug:           "contact"
#     },
#     {
#       id:              6,
#       institution_id:  1,
#       sort_order:      6,
#       topic_id:       'resources',
#       slug:           "training-guides-and-tutorials"
#     },
#     {
#       id:              7,
#       institution_id:  1,
#       sort_order:      7,
#       topic_id:       'resources',
#       slug:           "data-resources"
#     },
#     {
#       id:              8,
#       institution_id:  1,
#       sort_order:      8,
#       topic_id:       'resources',
#       slug:           "user-profiles"
#     },
#     {
#       id:              9,
#       institution_id:  1,
#       sort_order:      9,
#       topic_id:       'community',
#       slug:           "data-day-2009"
#     },
#     {
#       id:              10,
#       institution_id:  1,
#       sort_order:      10,
#       topic_id:       'community',
#       slug:           "data-day-2012"
#     },
#     {
#       id:              11,
#       institution_id:  1,
#       sort_order:      11,
#       topic_id:       'community',
#       slug:           "data-day-2013"
#     },
#     {
#       id:              12,
#       institution_id:  2,
#       sort_order:      1,
#       topic_id:       "about",
#       slug:           "what-is-the-data-common"
#     },
#     {
#       id:              13,
#       institution_id:  2,
#       sort_order:      2,
#       topic_id:       "about",
#       slug:           "faq"
#     },
#     {
#       id:              14,
#       institution_id:  2,
#       sort_order:      3,
#       topic_id:       "about",
#       slug:           "tools"
#     },
#     {
#       id:              15,
#       institution_id:  2,
#       sort_order:      4,
#       topic_id:       "about",
#       slug:           "partners"
#     },
#     {
#       id:              16,
#       institution_id:  2,
#       sort_order:      5,
#       topic_id:       "about",
#       slug:           "contact"
#     },
#     {
#       id:              17,
#       institution_id:  2,
#       sort_order:      6,
#       topic_id:       'resources',
#       slug:           "training-guides-and-tutorials"
#     },
#     {
#       id:              18,
#       institution_id:  2,
#       sort_order:      7,
#       topic_id:       'resources',
#       slug:           "data-resources"
#     },
#     {
#       id:              19,
#       institution_id:  2,
#       sort_order:      8,
#       topic_id:       'resources',
#       slug:           "user-profiles"
#     },
#     {
#       id:              20,
#       institution_id:  2,
#       sort_order:      9,
#       topic_id:       'community',
#       slug:           "data-day-2009"
#     },
#     {
#       id:              21,
#       institution_id:  2,
#       sort_order:      10,
#       topic_id:       'community',
#       slug:           "data-day-2012"
#     },
#     {
#       id:              22,
#       institution_id:  2,
#       sort_order:      11,
#       topic_id:       'community',
#       slug:           "data-day-2013"
#     }
#   ])

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