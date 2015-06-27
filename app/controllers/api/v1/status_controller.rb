module Api
  module V1
    class StatusController < ApplicationController
      def index
        render({ json: {
          status: "OK",
          revision: `cat /var/www/fantasy-celebrity-api/current/REVISION`.try(:chomp),
          pointCategories: [
            { category: "Legal", name: "DUI", points: 30 },
            { category: "Legal", name: "Drug Posession", points: 20 },
            { category: "Legal", name: "Disorderly Conduct", points: 25 },
            { category: "Career", name: "Leaked Sex Tape", points: 30 },
            { category: "Career", name: "Leaked Nude Pics", points: 25 }
          ]
        } })
      end
    end
  end
end
