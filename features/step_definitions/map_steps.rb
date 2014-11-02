Given(/^a map named "(.*?)" with topic "(.*?)"$/) do |title, topic_title|
  map = StaticMap.new(title: title)
  map.issue_areas << IssueArea.new(title: topic_title)
end

Given(/^I am on the map index page$/) do
  navigate_to 'the map index page'
end

Then(/^I should see a map named "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not see a map named "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end