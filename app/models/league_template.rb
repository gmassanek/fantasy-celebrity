class LeagueTemplate < ActiveRecord::Base
  has_many :leagues
  has_many :point_categories
end
