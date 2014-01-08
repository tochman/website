### UTILITY METHODS ###


def create_visitor
  #@visitor =FactoryGirl(:user)
  @visitor ||= { :first_name => "Testy",
                 :last_name => "McUserton",
                 :email => "example@example.com",
                 :password => "changeme",
                 :password_confirmation => "changeme" }
end


def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, @visitor)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  within ('#wrap') do
    fill_in "user_email", :with => @visitor[:email]
    fill_in "user_password", :with => @visitor[:password]
    fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
    click_button "Sign up"
    find_user
  end
end

def sign_in
  visit '/'
  within ('.navbar') do
    page.should have_css("form#loginForm", :visible => false)
    find('a', :text => 'Check-in').click
    page.should have_css("form#loginForm", :visible => true)
    within "form#loginForm" do
      fill_in "user_email", :with => @visitor[:email]
      fill_in "user_password", :with => @visitor[:password]
      click_button "Sign in"
    end
  end
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  username = [@visitor[:first_name], @visitor[:last_name]].join(' ')
  page.should have_css('a[href="/users/sign_out"]', :text => 'Log out', :visible => false)
  find("a[id='#{username}']").click
  page.should have_css('a[href="/users/sign_out"]', :text => 'Log out', :visible => true)
  #find('a[href="/users/sign_out"]').click
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  visit '/users/edit'
  #click_link "Edit account"
  within ('section#devise')  do
    fill_in "user_first_name", :with => "newname"
    fill_in "user_last_name", :with => "Lastname"
    fill_in "user_organization", :with => "Company"
    #fill_in "user_current_password", :with => @visitor[:password]
    click_button "Update"
  end

end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  current_user.should == @user
  page.should have_selector('a[href="/users/sign_out"]')
  page.should_not have_content "Sign up"
  page.should_not have_content "Check-in"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Check-in"
  page.should_not have_content "Log out"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password confirmation doesn't match"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password confirmation doesn't match "
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:first_name]
end

Given /^the sign in form is visible$/ do
  #expect(page).to have_form('loginForm')
  expect(page).to have_field('user_email')
  expect(page).to have_field('user_password')
  expect(page).to have_button('signin')
  #click_link 'Org Login'
end

Given(/^The database is clean$/) do
  DatabaseCleaner.clean
end