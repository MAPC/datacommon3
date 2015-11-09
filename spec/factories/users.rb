FactoryGirl.define do
  factory :user, aliases: [:active_user] do
    username   { Faker::Internet.user_name(10).delete('.') }
    first_name { Faker::Name.first_name    }
    last_name  { Faker::Name.last_name     }
    email      { Faker::Internet.email     }
    password   "pa55word"
    is_active    true
    is_staff     false
    is_superuser false

    trait :active do
      is_active  true
      activated_at 1.week.ago
    end

    trait :inactive do
      is_active  false
      activated_at nil
    end

    trait :staff do
      first_name "Steff"
      last_name  "Membre"
      is_staff    true
      is_superuser false
      last_login  20.minutes.ago
    end

    trait :admin do
      first_name  "Addy"
      last_name   "Ministrador"
      is_staff     true
      is_active    true
      is_superuser true
      last_login   5.minutes.ago
    end

  end
end
