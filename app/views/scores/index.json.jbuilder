json.scores @array do |f|
  json.name f[:name]
  json.score f[:score]
  json.created_at f[:created_at]
end
