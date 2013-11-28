Feature: In order to view the contributors to a project
  As a website owner
  I want to pull contributor information from GitHub
  And show it on a page

Background:

Scenario: Acces GitHub API
  Given I am on the "contributors" page
  Then show me the page
  Then I should see "Project contributors"
