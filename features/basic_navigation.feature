Feature: In order to make sure relevant content is shown to the user
  As a site admin
  I want to make sure the relevant content are displayed in the navigation bar

Scenario: Make sure Twitter Bootstrap navbar is present
  Given I am on the "Home" page
  Then the response status should be "200"
  Then I should see a navigation bar
  And I should see navigation links
  And I should see the "Contributors" link
  And I should see the "About" link


@allow-rescue
Scenario: Show custom 404 page
  When I am on the "foobar" page
  Then the page should be titled "404 File Not Found"
  And the response status should be "404"
  Then show me the page
  And I should see "We're sorry, but we couldn't find the page you requested"

@allow-rescue
Scenario: Show custom 500 page
  When I am on the "foobar" page
  Then the page should be titled "500 Internal Error"
  And the response status should be 500
  Then show me the page
  And I should see "We're sorry, but we couldn't process your request"