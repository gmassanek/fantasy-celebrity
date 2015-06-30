require "rails_helper"

RSpec.describe "League Positions", { type: :request } do
  describe "INDEX" do
    let(:league_template) { LeagueTemplate.find_by!({ title: "Bad Celebrity" }) }

    it "returns a list of all the positions for a league" do
      league = League.create!({ league_template: league_template })
      league.create_positions_from_league_template!

      get "/api/v1/leagues/#{league.id}/positions"
      expect(response).to be_success
      expect(json_body["positions"].size).to eq(league_template.positions.size)
    end
  end
end
