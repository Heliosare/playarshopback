# json.array! @games, partial: 'games/game', as: :game
json.games @games do | g |
    json.id g.id
    json.game_ref g.perso1
    json.name format_game(g.ref)
    # json.ref g.ref
    json.description g.description
    json.image g.image.url
    json.color1 g.color1
    json.color2 g.color2
    game_url(g, format: :json)
end
