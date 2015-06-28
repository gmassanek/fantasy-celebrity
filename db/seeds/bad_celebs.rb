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

    [["Actor", 2], ["Bench", 2]].each do |title, count|
      next if league_template.positions.find_by({ title: title })

      league_template.positions.create!({ title: title, suggested_count: count })
    end

    [["James", "Franco", "Actor"],
     ["Leonardo", "DiCaprio", "Actor"],
     ["Paul", "Giamati", "Actor"],
     ["Russel", "Crow", "Actor"]].each do |first, last, pos|
      next if league_template.players.find_by({ first_name: first, last_name: last })

      league_template.players.create!({
        first_name: first,
        last_name: last,
        position: Position.find_by({ title: pos })
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
    players = Player.pluck(:id).shuffle
    positions = league.all_positions
    roster_manager.set_roster(players.zip(positions.map(&:id)))

    team
  end
end
