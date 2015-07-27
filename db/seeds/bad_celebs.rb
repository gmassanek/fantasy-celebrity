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

    CSV.foreach("db/seeds/bad_celebs/league_positions.csv") do |(title, count, strict)|
      next if league_template.positions.find_by({ title: title })

      league_template.positions.create!({ title: title, suggested_count: count, strict: strict })
    end

    CSV.foreach("db/seeds/bad_celebs/players.csv") do |(name, pos)|
      first, last = name.split(" ", 2)
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
    league_template.leagues.find_by(title: "BadCelebs") || league_template.create_league!("BadCelebs")
  end

  def self.setup_teams(league)
    CSV.foreach("db/seeds/bad_celebs/teams.csv") do |(title, owner)|
      league.teams.find_or_create_by!({ title: title, owner: owner })
    end

    populate_teams_with_players(league)
  end

  def self.populate_teams_with_players(league)
    roster_assignments = {}
    CSV.foreach("db/seeds/bad_celebs/players.csv") do |(name, _, owner, lpos)|
      team = Team.find_by({ owner: owner })
      player = league.players.find { |p| p.name == name }
      position = league.positions.find { |p| p.title == lpos }

      roster_assignments[team] ||= []
      roster_assignments[team] << RosterSlot.new({
        league_player: player,
        league_position: position
      })
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
