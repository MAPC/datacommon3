FactoryGirl.define do
  
  factory :data_source, aliases: [:source] do
    title "American Community Survey"
    slug  "american-community-survey"
    url   "http://www.census.gov/acs/www/"
    description "The American Community Survey (ACS) is an ongoing survey that provides data every year -- giving communities the current information they need to plan investments and services. Information from the survey generates data that help determine how more than $400 billion in federal and state funds are distributed each year."
  end

  factory :another_data_source, aliases: [:another_source], class: DataSource do
    title "Department of Public Health"
    slug  "department-of-public-health"
    url   "http://www.dph.gov/"
    description "The Department of Public Health (DPH) is a thing"
  end

end