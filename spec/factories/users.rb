FactoryGirl.define do
  factory :user, aliases: [:active_user] do
    username   "username"
    first_name "First"
    last_name  "Last"
    sequence(:email) { |n| Faker::Internet.email("user_#{n}") }
    password   "pa55word"
    is_active    true
    is_staff     false
    is_superuser false

    trait :active do
      is_active  true
    end

    trait :inactive do
      is_active  false
    end

    trait :staff do
      first_name "Steff"
      last_name  "Membre"
      is_staff    true
    end

    trait :admin do
      first_name  "Addy"
      last_name   "Ministrador"
      is_staff     true
      is_active    true
      is_superuser true
    end

  end
end
