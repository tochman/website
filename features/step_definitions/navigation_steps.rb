And(/^the response status should be "(.*?)"$/) do |code|
  page.status_code.should eql(code.to_i)
end


Given(/^(?:|I )am on the "(.*?)" page$/) do |page|
  case page
    when "Home" then visit root_path('show')
    when "contributors" then visit contributors_path
    when "sign up" then visit new_user_registration_path
    when "sign in" then visit new_user_session_path
    when "about" then visit page_path('About')
    when "foobar" then visit ("/#{page}")
  end

end

Then(/^(?:|I )should see "(.*?)"$/) do |string|
  expect(page).to have_content(string)
end

Then /^show me the page$/ do
  save_and_open_page
end


Then /^(?:|I )should see the "([^\"]*)" link$/ do |link|
  page.should have_css("a", :text => link)
end

Then /^(?:|I )should not see the "([^\"]*)" link$/ do |link|
  page.should_not have_css("a", :text => link)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )click "([^"]*)"$/ do |button|
  click_link_or_button(button)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

Then(/^the page should be titled "(.*?)"$/) do |title|
  page.source.should have_css("title", :text => title, :visible => false)
end

Then /^I should see a link that points to "([^"]*)"$/ do |href_destination|
  page.should have_xpath("//a[@href='#{href_destination}']")
end

Given /^I am signed in as a charity worker (un)?related to "(.*?)"$/ do |negate, organization_name|
  organization = Organization.find_by_name(organization_name)
  if negate
    users = User.find_all_by_admin(false)
    user = users.find{|user| user.organization != organization}
  else
    user = organization.users.find{|user| !user.admin?}
  end
  page.set_rack_session("warden.user.user.key" => User.serialize_into_session(user).unshift("User"))
end

Given /^I am signed in as an? (non-)?admin$/ do |negate|
  user = User.find_by_admin(negate ? false:true)
  page.set_rack_session("warden.user.user.key" => User.serialize_into_session(user).unshift("User"))
end

Given /^I sign up as "(.*?)" with password "(.*?)" and password confirmation "(.*?)"$/ do |email, password,password_confirmation|
  fill_in "signup_email" , :with => email
  fill_in "signup_password" , :with => password
  fill_in "signup_password_confirmation" , :with => password_confirmation
  click_button "Sign up"
end

Given /^I sign in as a charity worker with permission to edit "(.*?)"$/ do |name|
  org = Organization.find_by_name name
  org.users   # TODO we will want some habtm to support this eventually
end

And /^I am signed in as the admin using password "(.*?)"$/ do |password|
  admin = User.find_by_admin(true)
  steps %Q{
    Given I am on the sign in page
    And I sign in as "#{admin.email}" with password "#{password}"
  }
end

And /^I am not signed in as the admin using password "(.*?)"$/ do |password|
  admin = User.find_by_admin(false)
  steps %Q{
    Given I am on the sign in page
    And I sign in as "#{admin.email}" with password "#{password}"
  }end

#TODO: Should we bypass mass assgiment in the creation via :without_protection?
Given /^the following users are registered:$/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /^that I am logged in as any user$/ do
  steps %Q{
     Given the following users are registered:
   | email             | password | confirmed_at         |
   | registered_user@example.com | pppppppp | 2007-01-01  10:00:00 |
  }
  steps %Q{
    Given I am on the sign in page
    And I sign in as "registered_user@example.com" with password "pppppppp"
  }
end

Then /^I should not be signed in as any user$/ do
  steps %Q{
    Given I am on the new charity page
    Then I should not see "Signed in as"
  }
end

When /^I sign out$/ do
  click_link 'Log out'
end

Given /^I sign in as "(.*?)" with password "(.*?)"$/ do |email, password|
  page.should have_css("form#loginForm", :visible => false)
  click_link "Login"
  page.should have_css("form#loginForm", :visible => true)
  within "form#loginForm" do
    fill_in "user_email" , :with => email
    fill_in "user_password" , :with => password
    click_button "Sign in"
  end
end

Then(/^I should see a link or button "(.*?)"$/) do |email|
  page.should have_css("a", :text => email, :visible => true)

end

Given /^I am on the sign in page$/ do
  step "I am on the home page"
  expect(page).to have_form('loginForm')
  expect(page).to have_field('user_email')
  expect(page).to have_field('user_password')
  expect(page).to have_button('signin')

end

Given /^I am on the sign up page$/ do
  step "I am on the home page"
  expect(page).to have_field('user_email')
  expect(page).to have_field('user_password')
  #expect(page).to have_button('signup')
end

When(/^I sign in as "(.*?)" with password "(.*?)" via email confirmation$/) do |email, password|
  user = User.find_by_email("#{email}")
  user.confirm!
  steps %Q{
    Given I am on the sign in page
    And I sign in as "#{email}" with password "#{password}"
  }
end
Then(/^I should be on the (.*?) page$/) do |page|
  URI.parse(current_url).path.should == '/' + page
end

When(/^the URL should contain "(.*?)"$/) do |string|
  URI.parse(current_url).path.should == '/' + string
end
When(/^I should see the (.*) link$/) do |link|
  page.should have_link /\A#{link}\Z/
end
Given(/^I click on "([^"]*)" link$/) do |link|
  within ('.navbar') do
    find('a', :text => /\A#{link}\Z/).click
  end
  end
Then(/^I should see input "([^"]*)"$/) do |input|
  within ('#loginForm') do
    find("input##{input}")
  end
end
Then(/^I should see form "([^"]*)"$/) do |id|
  page.should have_css("##{id}", :visible => true)
end

Then(/^I should not see form "([^"]*)"$/) do |id|
  page.should have_css("##{id}", :visible => false)
end