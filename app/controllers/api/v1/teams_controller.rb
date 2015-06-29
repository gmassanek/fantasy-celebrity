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
    end
  end
end
