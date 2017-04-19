json.company @target do | t |
  json.name t[:name]
  json.location t[:address]
  json.lat t[:lat]
  json.lng t[:lng]
  json.logo t[:logo]
  json.target t.targets
end
