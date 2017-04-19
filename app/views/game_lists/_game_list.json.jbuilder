json.extract! game_list, :id, :name, :description, :image, :level, :created_at, :updated_at
json.url game_list_url(game_list, format: :json)