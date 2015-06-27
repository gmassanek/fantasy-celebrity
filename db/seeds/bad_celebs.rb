class BadCelebs
  def self.seed!
    league_template = LeagueTemplate.find_or_create_by!({ title: "Bad Celebrity" })

    [["Legal", "foo", 10]].each do |group, title, value|
      unless league_template.point_categories.find_by({ title: title, group: group })
        league_template.point_categories.create!({ title: title, group: group, suggested_value: value })
      end
    end

    [["Actor", 2]].each do |title, count|
      unless league_template.positions.find_by({ title: title })
        league_template.positions.create!({ title: title, suggested_count: count })
      end
    end

    league = League.find_or_create_by!({ title: "Sample league", league_template: league_template })
    league.create_point_categories_from_league_template!
    league.create_positions_from_league_template!
  end
end
