Feature: In order to make sure relevant content is shown to the user
  As a site admin
  I want to make sure the relevant content are displayed in the navigation bar

Background:
  Given I am on the "Home" page
  Then the response status should be "200"

Scenario: Make sure Twitter Bootstrap navbar is present
  Then I should see a navigation bar

Scenario Outline: Test if the links on navbar are working
  And I should see navigation links
  And I should see the <link> link
Examples:
  | link           |
  | About          |
  | Check in       |
  | Sign up        |
  | Home           |
  | The Team       |
  | Agile Videos   |
  | Pairing groups |

Scenario: Test if the pulldown is present and contains login form
  Given I click on "navLogin" link
  Then I should see a login in form
  #id = "loginForm"
  And I should see "username" field
  And I should see "password" field
  And I should see "Sign in" button











@allow-rescue
Scenario: Show custom 404 page
  When I am on the "foobar" page
  Then the page should be titled "404 File Not Found"
  And the response status should be "404"
  And I should see "We're sorry, but we couldn't find the page you requested"

#TODO: Scenario needs to create exception. Postponed for now

#@allow-rescue

#Scenario: Show custom 500 page
#  When I am on the "ewew||" page
#  Then the page should be titled "500 Internal Error"
#  And the response status should be "500"
#  Then show me the page
#  And I should see "We're sorry, but we couldn't process your request"