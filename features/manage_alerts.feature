Feature: Manage alerts
  In order to see new development applications in my suburb
  I want to sign up for an email alert
  
  Scenario: Sign up for email alert
    Given I am on the home page
    When I fill in the email adress with "example@example.com"
    And I fill in the street address with "24 Bruce Road, Glenbrook"
    And I press "Create Alert"
    Then I should see "Now check your email"
    And I should receive an email
    When I open the email
    Then I should see "Please confirm your planning alert" in the email subject
    And I should see "24 Bruce Rd, Glenbrook NSW 2773" in the email body
    When I click the first link in the email
    Then I should see "your alert has been activated"
    And I should see "24 Bruce Rd, Glenbrook NSW 2773"
    And I should receive email alerts for the street address "24 Bruce Rd, Glenbrook NSW 2773"

  Scenario: Unsubscribe from an email alert
    Given I have received an email alert for "24 Bruce Rd, Glenbrook" with a size of "2000"
    When I click on the unsubscribe link in the email alert for "24 Bruce Rd, Glenbrook"
    Then I should see "You have been unsubscribed"
    And I should see "24 Bruce Rd, Glenbrook (within approximately 2 km)"
    And I should not receive email alerts for the street address "24 Bruce Rd, Glenbrook"