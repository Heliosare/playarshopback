json.extract! game, :id, :ref, :name, :description, :logo, :color1, :color2, :perso1, :perso2, :custom, :discount, :vuforia_name, :created_at, :updated_at
json.url game_url(game, format: :json)