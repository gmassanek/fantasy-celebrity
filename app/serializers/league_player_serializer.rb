class LeaguePlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :allowed_league_position_ids

  has_one :league_position

  def allowed_league_position_ids
    object.allowed_league_positions.map(&:id)
  end
end
