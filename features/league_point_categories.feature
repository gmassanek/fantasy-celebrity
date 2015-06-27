Feature: Leagues have Point Categories

  Scenario: You can see a league's point categories
    Given there is a BadCeleb League
    And that league has the default point categories
    When I go to that league's scoring page
    Then I should see the BadCeleb point categories
