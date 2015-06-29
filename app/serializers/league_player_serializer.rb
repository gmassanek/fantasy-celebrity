class LeaguePlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name

  has_one :league_position
end
