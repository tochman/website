Feature: Sign in
  As an existing User
  So that I can use the system
  I want to be able to login

Background:

Given the following users are registered:
  | email             | password | admin | organization | confirmed_at         |
  | registered_user-1@example.com | pppppppp |       |              | 2007-01-01  10:00:00 |
  | registered_user-2@example.com| pppppppp | true  |              | 2007-01-01  10:00:00 |
  | registered_user-3@example.com| pppppppp | false | Friendly     | 2007-01-01  10:00:00 |

  Given I am on the home page
  And the sign in form is visible

Scenario: Sign in for an existing non-admin user unassociated with any organization
  Given I sign in as "normal_user@example.com" with password "pppppppp"
  Then I should see a link or button "normal_user@example.com"

Scenario: Sign in with wrong password for an existing non-admin user unassociated with any organization
  Given I sign in as "normal_user@example.com" with password "12345"
  Then I should be on the Sign in page
  And I should see "I'm sorry, you are not authorized to login to the system."

Scenario: Sign in for an existing non-admin user associated with an organization
  Given I sign in as "charity_owner@example.com" with password "pppppppp"
  Then I should be on the charity page for "Friendly"
  And I should see a link or button "charity_owner@example.com"

Scenario: Sign in with wrong password for an existing non-admin user associated with an organization
  Given I sign in as "charity_owner@example.com" with password "12345"
  Then I should be on the Sign in page
  And I should see "I'm sorry, you are not authorized to login to the system."

Scenario: Sign in for an existing admin user
  Given I sign in as "site_admin@example.com" with password "pppppppp"
  Then I should be on the home page
  And I should see a link or button "site_admin@example.com"

Scenario: Sign in with wrong password for an existing admin user
  Given I sign in as "site_admin@example.com" with password "12345"
  Then I should be on the Sign in page
  And I should see "I'm sorry, you are not authorized to login to the system."

Scenario: Sign in for a non-existent user
  Given I sign in as "non-existent_user@example.com" with password "pppppppp"
  Then I should be on the sign in page
  And I should see "I'm sorry, you are not authorized to login to the system"

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