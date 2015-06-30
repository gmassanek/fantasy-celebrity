class Team < ActiveRecord::Base
  belongs_to :league
  has_many :roster_slots, { dependent: :destroy }
end
