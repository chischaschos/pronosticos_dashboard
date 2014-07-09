Feature: The Dashboard
  As a normal user
  In order to quickly know the status of the business
  I want to access different kinds of metrics
 
  Background:
    Given the data importing process runs

  Scenario:
    Given I go to the dashboard
    And the current date is "2014-07-07"
    Then I should see the Days Missing Data Report
