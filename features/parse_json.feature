Feature: In order to view the contributors to a project
  As a website owner
  I want to pull contributor information from GitHub
  And show it on a page

Background:


Scenario: Access Contributors page
  Given I am on the "contributors" page
  Then I should see "Project contributors"
  And I should see "tansaku"
  And I should see a link that points to "https://github.com/tansaku"
  And I should see "tochman"

