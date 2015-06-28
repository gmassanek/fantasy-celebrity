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

When(/^I go to my team$/) do
  visit "/leagues/#{@league.id}/teams/#{@team.id}"
end

Then(/^I should see my team's players$/) do
  @team.roster_slots.each do |roster_slot|
    expect(page).to have_content(roster_slot.player.first_name)
    expect(page).to have_content(roster_slot.player.last_name)
    expect(page).to have_content(roster_slot.league_position.title)
  end
end
