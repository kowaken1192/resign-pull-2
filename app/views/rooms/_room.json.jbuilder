json.extract! room, :id, :name, :introduction, :price, :address, :image, :created_at, :updated_at
json.url room_url(room, format: :json)
