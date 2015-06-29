class RosterManager
  def initialize(team)
    @team = team
  end

  def set_roster(player_assignments)
    @team.roster_slots.map(&:destroy)

    player_assignments.each do |player_id, position_id|
      @team.roster_slots.create!({ league_player_id: player_id, league_position_id: position_id })
    end
  end
end
