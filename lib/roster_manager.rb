class RosterManager
  def initialize(team, options = {})
    @team = team
    @league = @team.league
    @options = options
  end

  def set_roster(roster_slots)
    unless @options[:skip_validations]
      validate_league_roster_positions(roster_slots)
      validate_players_are_available(roster_slots)
    end

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

  private

  def validate_league_roster_positions(roster_slots)
    count_by_position(roster_slots).each do |position, requested_count|
      allowed_count = @league.positions.find { |p| p.id == position.id }.count
      if requested_count > allowed_count
        raise "There are too many #{position.title.pluralize}"
      end
    end
  end

  def validate_players_are_available(roster_slots)
    roster_slots.each do |roster_slot|
      if existing_slot = RosterSlot.find_by({ league_player_id: roster_slot.league_player_id })
        raise "#{roster_slot.league_player.name} is already on #{existing_slot.team.title}'s roster"
      end
    end
  end

  def count_by_position(roster_slots)
    @count_by_position ||= roster_slots.map(&:league_position).each_with_object(Hash.new(0)) {|v, h| h[v] += 1}
  end
end
