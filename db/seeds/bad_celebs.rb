require "csv"
require "roster_manager"

class BadCelebs
  def self.seed!
    league_template = setup_league_template
    league = setup_league(league_template)
    setup_team(league)
  end

  def self.setup_league_template
    league_template = LeagueTemplate.find_or_create_by!({ title: "Bad Celebrity" })

    [["Legal", "foo", 10]].each do |group, title, value|
      next if league_template.point_categories.find_by({ title: title, group: group })

      league_template.point_categories.create!({ title: title, group: group, suggested_value: value })
    end

    CSV.foreach("db/seeds/bad_celebs/league_positions.csv") do |(title, count)|
      next if league_template.positions.find_by({ title: title })

      league_template.positions.create!({ title: title, suggested_count: count })
    end

    CSV.foreach("db/seeds/bad_celebs/players.csv") do |(name, pos)|
      first, last = name.split(" ")
      next if league_template.players.find_by({ first_name: first, last_name: last })

      league_template.players.create!({
        first_name: first,
        last_name: last,
        position: Position.find_by!({ title: pos })
      })
    end

    league_template
  end

  def self.setup_league(league_template)
    league = League.find_or_create_by!({ title: "Sample league", league_template: league_template })
    league.create_point_categories_from_league_template!
    league.create_positions_from_league_template!
    league.create_players_from_league_template!

    league
  end

  def self.setup_team(league)
    team = league.teams.find_or_create_by!({ title: "New Team" })

    roster_manager = RosterManager.new(team)
    positions = league.all_positions

    players_ids = league.players.pluck(:id, :league_position_id)
    roster_slots = []
    positions.each do |position|
      roster_player_ids = players_ids.shuffle.find { |_, league_position_id| league_position_id == position.id }
      roster_slots << roster_player_ids
    end

    roster_manager.set_roster(roster_slots)

    team
  end
end
