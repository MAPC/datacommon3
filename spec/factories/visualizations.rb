FactoryGirl.define do
  factory :visualization, aliases: [:visual] do
    title "title"
    abstract "z"*90
    sessionstate "xml"*100
    owner_id 1
  end
end
