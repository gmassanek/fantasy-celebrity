Feature: Teams

  Scenario: You can view a team
    Given there is a BadCeleb League
    And that league has the default positions
    And that league has the default players
    And I have a team in that league
    And I have set up that team with players
    When I go to my team
    Then I should see my team's players
