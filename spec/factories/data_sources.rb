FactoryGirl.define do
  
  factory :data_source, aliases: [:source] do
    title "ACS"
    slug  "american-community-survey"
    url   "http://www.census.gov/acs/www/"
    description "The American Community Survey (ACS) is an ongoing survey that provides data every year -- giving communities the current information they need to plan investments and services. Information from the survey generates data that help determine how more than $400 billion in federal and state funds are distributed each year."
  end

end