Feature: Sign in
  As an existing User
  So that I can use the system
  I want to be able to login

Scenario: I sign in and edit my account
  Given I am logged in
  When I edit my account details
  Then I should see an account edited message