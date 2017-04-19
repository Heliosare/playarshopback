Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  apipie
  root 'apipie/apipies#index'
  # USERS
  post '/shops/sign_in', to: 'authentication#authenticate'
  post '/shops/sign_up', to: 'authentication#sign_up'
  post '/players/sign_in', to: 'authentication#authenticate'
  post '/players/sign_up', to: 'authentication#sign_up'

  # COMPANIES
  get '/companies/all', to: 'companies#all'
  post '/companies/payment', to: 'companies#payment'
  resources :users
  resources :companies
  get '/location', to: 'companies#location'
  # GAMES
  resources :discounts
  resources :games
  resources :game_lists
  get '/games/:id/editor', to: 'games#editt', as: 'editor'
  post '/games/:id', to: 'games#update', as: 'perso'
  get '/games/:id/delete', to: 'games#destroy'
  get '/recap/:id', to: "games#recap", as: 'recap'
  post '/email', to: 'users#email'

  resources :targets

  # REPORT
  resources :scores
  get '/stats', to: 'scores#stats', as: 'scores_stats'
  get '/stats_games', to: 'scores#stats_games'
end
