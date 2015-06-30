class TeamSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :roster_slots
end
