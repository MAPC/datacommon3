FactoryGirl.define do

  factory :hero do
    title 'Hero Saves Day'
    subtitle 'Flies through skies'
    active false
    content 'A hero saved the day today'

    image_file_name    'hero_image.png'
    image_content_type 'image/png'
    image_file_size     2024
    image_updated_at    Time.now

    trait :active do
      active true
    end

    trait :inactive do
      active false
    end
  end

end
