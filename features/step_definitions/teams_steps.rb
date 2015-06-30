require "roster_manager"

Given(/^I have a team in that league$/) do
  @team = @league.teams.create!({ title: "New Team" })
end

Given(/^I have set up that team with players$/) do
  roster_manager = RosterManager.new(@team)
  players = Player.pluck(:id).shuffle
  positions = @league.all_positions
  roster_manager.set_roster(players.zip(positions.map(&:id)))
end

When(/^I go to a team$/) do
  @team = @league.teams.first
  visit "/leagues/#{@league.id}/teams/#{@team.id}"
end

When(/^I go to view that league's standings$/) do
  visit "/leagues/#{@league.id}/standings"
end

When(/^I click on a team name$/) do
  @team = @league.teams.shuffle.first
  page.click_link @team.title
end

Then(/^I should see that team's players$/) do
  @team.roster_slots.each do |roster_slot|
    expect(page).to have_content(roster_slot.league_player.first_name)
    expect(page).to have_content(roster_slot.league_player.last_name)
    expect(page).to have_content(roster_slot.league_position.title)
  end
end

Then(/^I should see all the league's teams$/) do
  @league.teams.each do |team|
    expect(page).to have_content(team.title)
  end
end

Then(/^I should be on the team show page$/) do
  expect(current_url).to match(%r{leagues/#{@league.id}/teams/#{@team.id}})
end
