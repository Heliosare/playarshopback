json.extract! target, :id, :vuforia_name, :transaction_id, :target_id, :image, :path, :place, :city, :discountChance, :discountRate, :created_at, :updated_at
json.url target_url(target, format: :json)