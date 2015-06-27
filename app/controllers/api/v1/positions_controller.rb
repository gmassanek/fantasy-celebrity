module Api
  module V1
    class PositionsController < ApplicationController
      def index
        league = League.includes(:positions).find_by({ id: params[:league_id] })

        if league
          render({ json: { positions: league.positions } })
        else
          head :not_found
        end
      end
    end
  end
end
