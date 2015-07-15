class RosterManager
  def initialize(team)
    @team = team
  end

  def set_roster(roster_slots)
    @team.roster_slots.map(&:destroy)

    roster_slots.each do |roster_slot|
      league_player_id = roster_slot.league_player_id
      league_position_id = roster_slot.league_position_id

      if roster_slot.league_player.league_position.id != LeaguePosition.find(league_position_id).id
        player_name = roster_slot.league_player.name
        player_position = roster_slot.league_player.league_position.title
        raise "#{player_name} is a #{player_position} and cannot be played as a #{roster_slot.league_position.title}"
      end

      @team.roster_slots << roster_slot
    end
  end
end
