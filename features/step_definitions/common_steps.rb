Given(/^there is a BadCeleb League$/) do
  @league_template = LeagueTemplate.find_by!({ title: "Bad Celebrity" })
  @league = League.create!({ league_template: @league_template })
end

Given(/^that league has the default point categories$/) do
  @league.create_point_categories_from_league_template!
end

Given(/^that league has the default positions$/) do
  @league.create_positions_from_league_template!
end
