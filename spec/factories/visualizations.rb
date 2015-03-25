FactoryGirl.define do
  factory :visualization, aliases: [:visual] do
    title "title"
    institution_id 1
    sessionstate "xml"*100
  end
end
