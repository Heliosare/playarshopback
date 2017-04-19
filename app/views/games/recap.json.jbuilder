json.company do
  json.name @company.name
  json.logo @company.logo.url
end
json.target do
  json.place @target.place
  json.image @target.image.url
end
json.game do
  json.ref @game.ref
  json.name @game.name
  json.description @game.description
  json.color1 @game.color1
  json.color2 @game.color2
end
json.discount do
  json.success @discount.success
  json.fail   @discount.fail
end
