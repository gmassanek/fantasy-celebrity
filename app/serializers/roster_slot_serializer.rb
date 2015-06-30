class RosterSlotSerializer < ActiveModel::Serializer
  attributes :id, :status

  has_one :league_player
  has_one :league_position
end
