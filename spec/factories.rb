# Code guidance from Diaspora, Copyright (c) 2010-2011, Diaspora In

# For Guidance
# http://github.com/thoughtbot/factory_girl
# http://railscasts.com/episodes/158-factories-not-fixtures

FactoryGirl.define do

  factory :user do
    sequence(:username) { |n| "planner#{n}" }
    sequence(:first_name) { |n| "Matt#{n}"  }
    sequence(:last_name)  { |n| "Lloyd#{n}" }
    email { |u| "#{u.username}@mapc.org"}
    password "secret"
    password_confirmation { |u| u.password }
  end

  factory :institution do
    short_name "Metro Boston"
    long_name "Metropolitan Boston"
    subdomain "metroboston"
    association :branding, strategy: :build
  end

  factory :branding do
    logo_url "eh"
    tagline "meh"
    map_gallery_intro "beh"
    logos "yeh"
    institution_id 1
  end

  # factory :profile
  # end

  # factory :visualization do
  # end

  factory :static_map do

    year           2000
    month          "Jan"
    title          "Population"
    abstract       "This is an abstract."
    pdf_page       "a/path/to/file.pdf"
    thumbnail      "a/path/to/thumb.jpg"
    institution_id 1


    factory :map_with_topic do
      transient do
        topic_title "Demographics"
      end
      after(:create) do |map, vals|
        create(:issue_area, title: vals.topic_title, static_map: map)
      end
    end

  end

  factory :data_source do
    title "ACS"
    slug  "american-community-survey"
    url   "http://www.census.gov/acs/www/"
  end

  factory :issue_area do
    title "Demographics"
    slug  "demographics"
    order  1
  end

end