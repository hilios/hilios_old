Feature: Navigation
  In order have a good user experience
  As a guest
  I want that all links are working
  
  Scenario: Click on all links on the page and sub-pages
    Given I am on the homepage
    Then should not have any broken link
    