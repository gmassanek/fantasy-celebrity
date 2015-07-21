Rails.application.routes.draw do
  match "*path", { to: "application#handle_options_request", via: [:options] }

  namespace :api do
    namespace :v1 do
      get({ "status" => "status#index" })

      resources :leagues do
        resources :league_point_categories, { only: [:index] }
        resources :positions, { only: [:index] }
      end

      resources :teams, { only: [:show, :index] } do
        member do
          put :roster_slots
        end
      end
    end
  end
end
