Feature: Sign out
  To protect my account from unauthorized access
  A signed in user
  Should be able to sign out

  Scenario: User signs out
    Given I am logged in
    Then show me the page
    When I sign out
    Then I should see a signed out message
    When I return to the site
    Then I should be signed out