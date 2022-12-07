json.extract! gift, :id, :name, :price, :description, :created_at, :updated_at
json.url gift_url(gift, format: :json)
