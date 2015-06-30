Feature: Teams

  Scenario: You can view a team
    Given the BadCeleb League seeds have been run
    When I go to a team
    Then I should see that team's players

  Scenario: You can view a league's teams
    Given the BadCeleb League seeds have been run
    When I go to view that league's standings
    Then I should see all the league's teams

  Scenario: You can navigate to a team from the league's teams
    Given the BadCeleb League seeds have been run
    When I go to view that league's standings
    And I click on a team name
    Then I should be on the team show page
