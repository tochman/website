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


  Scenario: Retrieve password
    Given I am on the sign in page
    And I click "Forgot your password?"
    Then I should be on the Forgot your password page
    And I should see "Please enter your email address below"
    When I fill in "user_retrieval_email" with "registered_user-1@example.com"
    And I press "Send me reset password instructions"
    Then I should see "You will receive an email with instructions about how to reset your password in a few minutes."

  Scenario: Edit user profile
    Given that I am logged in as any user
    Then I should see "Edit account"
    When I click "Edit account"
    Then I should be on the Edit account page
    And I should see "Edit User"
    And I should see "Cancel my account"

  Scenario: Update user email
    Given I am on the sign in page
    And I sign in as "registered_user-1@example.com" with password "pppppppp"
    And I click "Edit account"
    And I fill in "user_email" with "new_email@example.com"
    And I fill in "user_current_password" with "pppppppp"
    And I press "Update"
    Then I should see "You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address."

  Scenario: Update user email - wrong current password
    Given I am on the sign in page
    And I sign in as "registered_user-1@example.com" with password "pppppppp"
    And I click "Edit account"
    And I fill in "user_email" with "new_email@example.com"
    And I fill in "user_current_password" with "12345"
    And I press "Update"
    Then I should see "Current password is invalid"

  Scenario: Update user password
    Given I am on the sign in page
    And I sign in as "registered_user-1@example.com" with password "pppppppp"
    And I click "Edit account"
    And I fill in "user_password" with "qqqqqqqq"
    And I fill in "user_password_confirmation" with "qqqqqqqq"
    And I fill in "user_current_password" with "pppppppp"
    And I press "Update"
    Then I should see "You updated your account successfully."

  Scenario: Update user password - wrong current password
    Given I am on the sign in page
    And I sign in as "registered_user-1@example.com" with password "pppppppp"
    And I click "Edit account"
    And I fill in "user_password" with "qqqqqqqq"
    And I fill in "user_password_confirmation" with "qqqqqqqq"
    And I fill in "user_current_password" with "123456"
    And I press "Update"
    Then I should see "Current password is invalid"

  Scenario: Update user password - wrong confirmation
    Given I am on the sign in page
    And I sign in as "registered_user-1@example.com" with password "pppppppp"
    And I click "Edit account"
    And I fill in "user_password" with "qqqqqqqq"
    And I fill in "user_password_confirmation" with "12345"
    And I fill in "user_current_password" with "pppppppp"
    And I press "Update"
    Then I should see "Password doesn't match confirmation"

  Scenario: Update user password - wrong confirmation and wrong current password
    Given I am on the sign in page
    And I sign in as "registered_user-1@example.com" with password "pppppppp"
    And I click "Edit account"
    And I fill in "user_password" with "qqqqqqqq"
    And I fill in "user_password_confirmation" with "12345"
    And I fill in "user_current_password" with "12345"
    And I press "Update"
    Then I should see "2 errors prohibited this user from being saved:"
    And I should see "Password doesn't match confirmation"
    And I should see "Current password is invalid"