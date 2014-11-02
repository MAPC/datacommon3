
Then(/^I get a download with the filename "(.*?)"$/) do |filename, table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    page.response_headers['Content-Disposition'].should include("filename=\"#{hash[:filename]}\"")
  end
end

When(/^I filter by (.*?) for "(.*?)"$/) do |filter, value|
  pending # express the regexp above with the code you wish you had
end

Given(/^many layers$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be on the layer index page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I see "(.*?)"$/) do |content|
  page.should have_content(content)
end

Then(/^I do not see "(.*?)"$/) do |content|
  page.should_not have_content(content)
end

Then(/^I should see pagination controls$/) do
  page.should have_css('.pagination li')
end

When(/^I select a layer$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be on the layer show page$/) do
  confirm_on_page('layer/show')
end

Given(/^I am on the layer index page$/) do
  navigate_to('layers/index')
end