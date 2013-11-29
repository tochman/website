Feature: In order to make sure relevant content is shown to the user
  As a site admin
  I want to make sure the relevant content are displayed in the navigation bar

Scenario: Make sure Twitter Bootstrap navbar is present
  Given I am on the "Home" page
  Then I should see a navigation bar
  And I should see navigation links
  And I should see the "Contributors" link
  And I should see the "About" link
