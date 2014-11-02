Given(/^a user with username "([^\"]*)" and password "([^\"]*)"$/) do |username, password|
  @me ||= FactoryGirl.create(:user,
                             username: username,
                             password: password,
                             password_confirmation: password)
  @me.reload
end

Given(/^I have been redirected from my profile edit page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be on my profile edit page$/) do
  confirm_on_page('profile/') # TODO: Add helpers (in diapsora/features/navigation_helpers)
end

When(/^I sign in manually as "(.*?)" with password "(.*?)"$/) do |arg1, arg2|
  manual_login
  save_and_open_page
end

Given(/^I am signed in$/) do
  manual_login
end

Given(/^I am signed out$/) do
  pending # TODO automatic or manual logout
end

Then(/^I should be on the new user session page$/) do
  confirm_on_page('sessions/new')
end

When(/^I try to edit the profile for user "(.*?)"$/) do |arg1|
  pending # TODO follow user edit path
end