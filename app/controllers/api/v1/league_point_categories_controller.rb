module Api
  module V1
    class LeaguePointCategoriesController < ApplicationController
      def index
        league = League.includes(:league_point_categories).find_by({ id: params[:league_id] })

        if league
          render({ json: league.league_point_categories })
        else
          head :not_found
        end
      end
    end
  end
end
