class LeagueTemplate < ActiveRecord::Base
  has_many :leagues
  has_many :players
  has_many :point_categories
  has_many :positions
end
