Feature: As a site administrator
  I want to be able to show all team members on a page

  Background:
    Given the following contributors exist:
      | login  | avatar_url                    | html_url                 | contributions |
      | thomas | http://example.com/thomas.png | http://github.com/thomas | 10            |
      | john   | http://example.com/john.png   | http://github.com/john   | 10            |

  Scenario: Display project contributors
    Given I am on the "contributors" page
    Then I should be on the contributors page
    And I should see "The Team"
    And I should see "thomas"
    And I should see "john"

