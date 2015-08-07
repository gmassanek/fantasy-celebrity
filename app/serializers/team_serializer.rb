class TeamSerializer < ActiveModel::Serializer
  attributes :id, :title, :owner

  has_many :roster_slots
end
