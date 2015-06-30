class LeaguePlayer < ActiveRecord::Base
  belongs_to :league
  belongs_to :league_position
  belongs_to :player

  def name
    "#{first_name} #{last_name}"
  end
end
