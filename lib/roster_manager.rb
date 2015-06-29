class RosterManager
  def initialize(team)
    @team = team
  end

  # TODO Fix the signature of this method, currently takes an array of [player_id, position_id]
  def set_roster(player_assignments)
    @team.roster_slots.map(&:destroy)

    player_assignments.each do |league_player_id, league_position_id|
      if LeaguePlayer.find(league_player_id).league_position.id != LeaguePosition.find(league_position_id).id
        player = LeaguePlayer.find(league_player_id)
        league_position = LeaguePosition.find(league_position_id)

        raise "#{player.name} is a #{player.league_position.title} and cannot be played as a #{league_position.title}"
      end

      @team.roster_slots.create!({ league_player_id: league_player_id, league_position_id: league_position_id })
    end
  end
end
