FactoryGirl.define do

  factory :dynamic_visualization, aliases: [:dynamic_visual] do
    title Faker::Commerce.product_name
    year  2009
    overviewmap  false
    type 'municipality'

    session_state_file_name    { "#{title.parameterize}.xml" }
    session_state_content_type "application/xml"
    session_state_file_size    Faker::Number.number(4)
    session_state_updated_at   Faker::Time.forward

    trait :no_attachment do
      session_state_file_name    nil
      session_state_content_type nil
      session_state_file_size    nil
      session_state_updated_at   nil
    end

    trait :subregion do
      type 'subregion'
    end
  end

end
