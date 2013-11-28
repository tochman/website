require 'webmock/cucumber'
require 'capybara/cucumber'
#require 'uri-handler'
include ApplicationHelper


Given(/^I am on the "(.*?)" page$/) do |page|
  visit ("/#{page}")
end

Then(/^I should see "(.*?)"$/) do |string|

  expect(page).to have_content(string)

end

Then /^show me the page$/ do
  save_and_open_page
end