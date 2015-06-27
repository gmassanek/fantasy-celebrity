require 'rails_helper'

RSpec.describe "League Point Categories", :type => :request do
  describe "INDEX" do
    let(:league_template) { LeagueTemplate.find_by!({ title: "Bad Celebrity" }) }

    it "returns a list of all the point categories for a league" do
      league = League.create!({ league_template: league_template })
      league.create_point_categories_from_league_template!

      get "/api/v1/leagues/#{league.id}/point_categories"
      expect(response).to be_success
      expect(json_body['pointCategories'].size).to eq(league_template.point_categories.size)
    end
  end
end
