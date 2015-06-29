require "rails_helper"

RSpec.describe "Teams", { type: :request } do
  describe "SHOW" do
    # let(:league_template) { LeagueTemplate.find_by!({ title: "Bad Celebrity" }) }
    # let(:league) { League.find_by!({ title: "Sample league" }) }
    let(:team) { Team.find_by!({ title: "New Team" }) }

    it "includes base team attributes" do
      get "/api/v1/teams/#{team.id}"
      expect(response).to be_success
      expect(json_body["team"]["id"]).to eq(team.id)
      expect(json_body["team"]["title"]).to eq(team.title)
      expect(json_body["team"]["roster_slot_ids"].size).to eq(team.roster_slots.size)
    end

    it "includes roster_slots" do
      get "/api/v1/teams/#{team.id}"
      expect(response).to be_success
      expect(json_body["roster_slots"].size).to eq(team.roster_slots.size)
      expect(json_body["roster_slots"][0]["id"]).to be
      expect(json_body["roster_slots"][0]["league_player_id"]).to be
      expect(json_body["roster_slots"][0]["league_position_id"]).to be
    end

    it "includes league_players" do
      get "/api/v1/teams/#{team.id}"
      expect(response).to be_success
      expect(json_body["league_players"].size).to eq(team.roster_slots.size)
      expect(json_body["league_players"][0]["id"]).to be
      expect(json_body["league_players"][0]["first_name"]).to be
      expect(json_body["league_players"][0]["last_name"]).to be
    end

    it "includes league_positions" do
      get "/api/v1/teams/#{team.id}"
      expect(response).to be_success
      expect(json_body["league_positions"].size).to eq(team.roster_slots.map(&:league_position_id).uniq.size)
      expect(json_body["league_positions"][0]["id"]).to be
      expect(json_body["league_positions"][0]["title"]).to be
    end
  end
end
