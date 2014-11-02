And(/^an institution$/) do
  FactoryGirl.create(:institution)
end

Then(/^I am on the institution page$/) do
  confirm_on_page 'the institution page'
end

Given(/^I click on my name in the header$/) do
  click_link("Hi, #{@me.name}")
end

When(/^I follow "(.*?)"$/) do |link|
  click_link(link)
end

Given(/^I am on the homepage$/) do
  confirm_on_page('institution/show')
end
