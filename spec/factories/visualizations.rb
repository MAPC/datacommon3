FactoryGirl.define do
  factory :visualization, aliases: [:visual] do
    title "A Visualization Title"
    abstract "z"*90
    sessionstate "xml"*100
    association :owner, factory: :user
  end
end
