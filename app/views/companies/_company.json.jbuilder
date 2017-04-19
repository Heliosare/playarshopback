json.extract! company, :id, :name, :logo, :siret, :created_at, :updated_at
json.url company_url(company, format: :json)