Feature: Sign in
  As an existing User
  So that I can use the system
  I want to be able to login

Background:

Given the following users are registered:
  | email                         | password |
  | normal_user@example.com       | pppppppp |


  Given I am on the "Home" page
  And the sign in form is visible

Scenario: Sign in for an existing user
  Given I sign in as "normal_user@example.com" with password "pppppppp"
  Then I should see a link or button "normal_user@example.com"

Scenario: Sign in with wrong password for an existing user
  Given I sign in as "normal_user@example.com" with password "12345"
  Then I should be on the Sign in page
  And I should see "I'm sorry, you are not authorized to login to the system."


@javascript
Scenario: Check that signup toggle works
  Given I am on the home page
  And I click "Login"
  Then the "menuLogin" should be "open"
  Then I should see "New organization? Sign-up.."
  Given I click "toggle_link"
  Then the "loginForm" should be "collapse"
  Then I should see "Already a member? Login"
  Given I click "toggle_link"
  Then the "register" should be "collapse"


Scenario: Check class of flash notice  - error
  Given I sign in as "site_admin@example.com" with password "12345"
  Then I should be on the Sign in page
  And the "flash_alert" should be "alert-error"


Scenario: Check class of flash notice  - success
  Given I sign in as "site_admin@example.com" with password "pppppppp"
  Then I should be on the Sign in page
  And the "flash_notice" should be "alert-success"