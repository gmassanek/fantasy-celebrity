require "csv"
require "roster_manager"

class BadCelebs
  def self.seed!
    delete_things
    league_template = setup_league_template
    league = setup_league(league_template)
    setup_teams(league)
  end

  def self.setup_league_template
    league_template = LeagueTemplate.find_or_create_by!({ title: "Bad Celebrity" })

    CSV.foreach("db/seeds/bad_celebs/point_categories.csv") do |(group, title, value)|
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
    league = League.find_or_create_by!({ title: "BadCelebs", league_template: league_template })
    league.create_point_categories_from_league_template!
    league.create_positions_from_league_template!
    league.create_players_from_league_template!

    league
  end

  def self.setup_teams(league)
    CSV.foreach("db/seeds/bad_celebs/teams.csv") do |(title, _)|
      league.teams.find_or_create_by!({ title: title })
    end

    populate_teams_with_players(league)
  end

  def self.populate_teams_with_players(league)
    roster_assignments = {}
    9.times do |i|
      league.teams.each.with_index do |team, j|
        offset = (i * 13) + j
        player = league.players[offset]
        next unless player
        roster_assignments[team] ||= []
        roster_assignments[team] << [player.id, player.league_position_id]
      end
    end

    roster_assignments.each do |team, assignments|
      RosterManager.new(team).set_roster(assignments)
    end
  end

  def self.delete_things
    Team.destroy_all
    RosterSlot.destroy_all
  end
end
