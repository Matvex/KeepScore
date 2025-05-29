Rails.application.routes.draw do
  root "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get "login", to: "sessions#new", as: "new_session"
  post "login", to: "sessions#create", as: "sessions"
  delete "logout", to: "sessions#destroy", as: "logout"

  resources :users, only: [ :index ]

  get    "game_sessions",          to: "game_sessions#index",  as: :game_sessions
  get    "game_sessions/new",      to: "game_sessions#new",    as: :new_game_session
  post   "game_sessions",          to: "game_sessions#create"
  get    "game_sessions/:id/edit", to: "game_sessions#edit",   as: :edit_game_session
  patch  "game_sessions/:id",      to: "game_sessions#update"
  delete "game_sessions/:id",      to: "game_sessions#destroy", as: :game_session

  get    "scores",   to: "scores#index",     as: :scores

  get    "stats",    to: "stats#index",      as: :stats
end
