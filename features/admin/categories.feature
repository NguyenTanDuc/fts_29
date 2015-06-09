Feature: Manage Categories
  In order to manage a category
  As an admin
  I want to CRUD categories

  Background: 
    Given An account admin
    And I have some categories below:
    | name       | max_question | max_time |  
    | Category 1 | 10           | 20       |  
    | Category 2 | 15           | 20       |

  Scenario: Show categories list
    Given I visit admin categories index page
    Then I should see 2 categories in a table
  
  Scenario: Create category with valid input
    Given I visit new category page
    Then I should see form create new categories
    When I fill in the input name: "new category", max_question: "10", max_time: "20"
    And I click on submit button
    Then I should see a message "Create success"

  Scenario: Create category with invalid input  
    Given I visit new category page
    Then I should see form create new categories
    When I fill in the input name: " ", max_question: "abc", max_time: "def"
    And I click on submit button
    Then I should see a danger message "4 errors"

  Scenario: Update category with valid input
    Given I visit edit category page with category_id: "1"
    Then I should see form edit category "1"
    When I change the input name: "edit category", max_question: "15", max_time: "15"
    And I click on submit button
    Then I should see a message "Update success"

  Scenario: Update category with invalid input
    Given I visit edit category page with category_id: "1"
    Then I should see form edit category "1"
    When I change the input name: " ", max_question: " ", max_time: " "
    And I click on submit button
    Then I should see a danger message "6 errors"

  @wip
  Scenario: Destroy category
    Given I visit admin categories index page 
    When I click on "Delete" link 
