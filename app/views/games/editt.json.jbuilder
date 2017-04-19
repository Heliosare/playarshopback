json.array!(@games) do |target|
  json.target_image target.image.url
  json.shop_logo @company.logo.url
  # json.game_logo @game.image.url
# json.logo_image @game.image
end
