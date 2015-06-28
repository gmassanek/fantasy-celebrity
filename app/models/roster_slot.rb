class RosterSlot < ActiveRecord::Base
  belongs_to :team
  belongs_to :league_position
  belongs_to :player

  enum({ status: [:active, :inactive] })
end
