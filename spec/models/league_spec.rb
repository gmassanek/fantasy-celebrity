require 'rails_helper'

RSpec.describe League, :type => :model do
  describe "create_point_categories_from_league_template" do
    let(:league_template) { LeagueTemplate.find_by!({ title: "Bad Celebrity" }) }

    it "copies all the info from the template" do
      league = League.create!({ league_template: league_template })
      league.create_point_categories_from_league_template!
      expect(league.point_categories.size).to eq(league_template.point_categories.size)
    end

    it "is idempotent" do
      league = League.create!({ league_template: league_template })
      league.create_point_categories_from_league_template!
      league.create_point_categories_from_league_template!
      league.create_point_categories_from_league_template!
      expect(league.point_categories.size).to eq(league_template.point_categories.size)
    end

    it "does not delete extra point categories" do
      league = League.create!({ league_template: league_template })
      league.point_categories.create!({ title: "Foobar meebar", group: "Legal", value: 20 })
      league.create_point_categories_from_league_template!

      expect(league.point_categories.size).to eq(league_template.point_categories.size + 1)
    end

    it "does not clobber point overrides" do
      league = League.create!({ league_template: league_template })
      league.create_point_categories_from_league_template!
      league.point_categories[0].update(value: 100)

      expect(league.point_categories[0].value).to eq(100)
    end

    it "does nothing if ther eis no template" do
      league = League.create!
      league.create_point_categories_from_league_template!

      expect(league.point_categories.size).to eq(0)
    end
  end

  describe "create_positions_from_league_template" do
    let(:league_template) { LeagueTemplate.find_by!({ title: "Bad Celebrity" }) }

    it "copies all the info from the template" do
      league = League.create!({ league_template: league_template })
      league.create_positions_from_league_template!
      expect(league.positions.size).to eq(league_template.positions.size)
    end

    it "is idempotent" do
      league = League.create!({ league_template: league_template })
      league.create_positions_from_league_template!
      league.create_positions_from_league_template!
      league.create_positions_from_league_template!
      expect(league.positions.size).to eq(league_template.positions.size)
    end

    it "does not delete extra point categories" do
      league = League.create!({ league_template: league_template })
      league.positions.create!({ title: "Foobar meebar", count: 2 })
      league.create_positions_from_league_template!

      expect(league.positions.size).to eq(league_template.positions.size + 1)
    end

    it "does not clobber point overrides" do
      league = League.create!({ league_template: league_template })
      league.create_positions_from_league_template!
      league.positions[0].update(count: 10)

      expect(league.positions[0].count).to eq(10)
    end

    it "does nothing if ther eis no template" do
      league = League.create!
      league.create_point_categories_from_league_template!

      expect(league.positions.size).to eq(0)
    end
  end
end
