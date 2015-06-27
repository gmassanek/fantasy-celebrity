module Api
  module V1
    class PointCategoriesController < ApplicationController
      def index
        league = League.includes(:point_categories).find_by({ id: params[:league_id] })

        if league
          render({ json: { pointCategories: league.point_categories } })
        else
          head :not_found
        end
      end
    end
  end
end
