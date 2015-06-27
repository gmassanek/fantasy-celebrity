module Api
  module V1
    class StatusController < ApplicationController
      def index
        render({ json: {
          status: "OK",
          revision: `cat /var/www/fantasy-celebrity-api/current/REVISION`.try(:chomp)
        } })
      end
    end
  end
end
