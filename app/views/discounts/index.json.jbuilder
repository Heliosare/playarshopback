# json.array! @discounts, partial: 'discounts/discount', as: :discount
json.discount @array do | f |
  json.name f[:name]
  json.success f[:success]
  json.created_at f[:created_at]
end
