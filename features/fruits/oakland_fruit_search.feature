Feature: oakland Fruit search
#Background:
#  Given user is on fruit search page

  Scenario: verify the user can search for the fruits
    Given user is on fruit search page
    When user search for the fruit Rose
    Then user should see the results related for Rose
    And verify the search results count is not more than 10

  Scenario Outline: verify the user can search for different fruits
    Given user is on fruit search page
    When user search for the fruit <fruit_name>
    Then user should see the results related for <fruit_name>
    And verify the search results count is not more than <no_of_results>

    Examples:
      | fruit_name | no_of_results |
      | Rose       | 10            |
      | Sunflower  | 10            |

  Scenario Outline: verify the user can search for different plants
    Given user is on fruit search page
    When user search for the fruit <fruit_name>
    Then user should see the results related for <fruit_name>
    And verify the search results count is not more than <no_of_results>
    And verify the header details of the plant
      | fruit_details |
      | fruit Type    |
      | fruit Height  |
      | Flower Height |
      | Spreed        |
      | Sunlight      |
    Examples:
      | fruit_name | no_of_results |
      | Rose       | 10            |
      | Sunflower  | 10            |




  Scenario: verify user can add the plants to wishlist
    Given user is on plant search page
    When user search for the plant Rose
    And user add the first result to the wish list
    Then verify the added plant is showing under wishlist page

  Scenario: verify user can modify the item quantity in the wishlist
    Given user is on plant search page
    When user search for the plant Rose
    And user add the first result to the wish list
    And user modifies the quantity of the wish list item
    Then verify user can see the updated quantity

#Imperative Style
  Scenario: verify user can modify the item quantity in the wish list using imperative style
    Then user can modified the quantity in the wish list

  Scenario: verify the user can empty the wishlist
    Given user is on plant search page
    When user adds the plant Rose to the wish list
    And user empty the wishlist
    Then user should see the confirmation message "Your wishlist is currently empty!"

  Scenario: verify the search results on a page should not be more than 10-----------------this case is combined with first case
    Given user is on plant search page
    When user search for the plant Rose
    Then user should see the results related for Rose
    And verify the search results is not more than 10

  Scenario: Get the plant search details - plant type, plant height, flower height, spread, sunlight
    Given user is on plant search page
    When user search for the plant Rose
    Then user should see the results related for Rose
    And get the details of the plant

  Scenario: Verify the plant search details- plant type, plant height, flower height, spread, sunlight are correct
    Given user is on plant search page
    When user search for the plant Rose
    Then user should see the results related for Rose
    And verify the details of the plant
      | plant_details | plant_values |
      | Plant Type    | perennial    |
      | Plant Height  | 4  feet      |
      | Flower Height | 6 feet       |
      | Spreed        | 24 inches    |
      | Sunlight      | full sun     |

