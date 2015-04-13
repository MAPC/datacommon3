FactoryGirl.define do
  factory :issue_area, aliases: [:topic] do
    title 'Public Health'
    slug  { title.to_s.parameterize }
    sequence(:order) {|n| n }
  end

end
