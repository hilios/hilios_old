Feature: Navigation
  In order to be able navigate through all my info
  As a common user of the site
  I want that all links are ok
  
  Scenario: Click on all links on the page and sub-pages
    Given I am on the homepage
    Then should not have any broken link
    