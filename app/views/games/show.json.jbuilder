# json.partial! "games/game", game: @game
json.id   @game.id
json.ref @game.ref
json.name @game.name
json.description @game.description
# json.image @game.image
json.logo @game.image.url
json.color1 @game.color1
json.color2 @game.color2
json.perso1 @game.perso1
json.perso2 @game.perso2
json.custom @game.custom
# json.discount @game.discount
json.vuforia_name @game.vuforia_name
