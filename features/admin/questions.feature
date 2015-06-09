Feature: Manage Questions
  In order to manage question and answers
  As an admin
  I want to CRUD question and answers

  Background:
    Given I login with admin account
    And I have a categories list below:
    | name       | max_question | max_time |  
    | Category 1 | 10           | 20       |  
    | Category 2 | 15           | 20       |  
    And I have a questions list below:
    | content    | category_id |  
    | Question 1 | 1           |  
    | Question 2 | 2           |  
    | Question 3 | 1           |  

  Scenario: Show question list
    Given I visit question index page
    Then I should see "3" question in the table