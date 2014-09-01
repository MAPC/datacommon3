class PostgresLayer < ActiveHash::Base

  self.data = [
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
      tablenum:    "b19037"
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
      tablename:  "b19037_hh_income_by_age_acs_bg"
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
      tablename:  "hous_hh_fam_00_10m"  
    }
  ]
end

