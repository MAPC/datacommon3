FactoryGirl.define do
  factory :logo do
    alt_text "A descriptive alt text"
    image_file_name    { "logo.png" }
    image_content_type "image/png"
    image_file_size    Faker::Number.number(4)
    image_updated_at   Faker::Time.forward

  end

end
