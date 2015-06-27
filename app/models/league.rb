class League < ActiveRecord::Base
  belongs_to :league_template
  has_many :point_categories, { class_name: LeaguePointCategory }
  has_many :positions, { class_name: LeaguePosition }

  def create_point_categories_from_league_template!
    return unless league_template

    league_template.point_categories.each do |point_category|
      next if point_categories.find_by({ point_category_id: point_category.id })

      point_categories.create!({
        point_category: point_category,
        title: point_category.title,
        group: point_category.group,
        value: point_category.suggested_value
      })
    end
  end

  def create_positions_from_league_template!
    return unless league_template

    league_template.positions.each do |position|
      next if positions.find_by({ position_id: position.id })

      positions.create!({
        position: position,
        title: position.title,
        count: position.suggested_count
      })
    end
  end
end
