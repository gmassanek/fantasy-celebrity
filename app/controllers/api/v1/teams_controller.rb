require "roster_manager"

module Api
  module V1
    class TeamsController < ApplicationController
      def show
        team = Team.includes({ roster_slots: [:league_player, :league_position] }).find_by({ id: params[:id] })

        if team
          render({ json: team })
        else
          head :not_found
        end
      end

      def index
        teams = Team.includes({
          roster_slots: [
            { league_player: [:league_position] },
            :league_position
          ]
        }).where({ league_id: params[:league_id] })

        if teams.present?
          render({ json: teams })
        else
          head :not_found
        end
      end

      def roster_slots
        team = Team.find(params[:id])
        roster_manager = RosterManager.new(team)
        roster_slots = params["team"]["roster_slots"].map do |roster_slot_data|
          RosterSlot.new(roster_slot_data.permit(:league_player_id, :league_position_id))
        end

        roster_manager.set_roster(roster_slots)

        render({ json: team })
      rescue RosterManager::InvalidRoster => ex
        render({ json: { error: ex.to_s }, status: 422 })
      end
    end
  end
end
