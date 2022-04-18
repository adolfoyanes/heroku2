json.extract! item, :id, :title, :description, :barcode, :available_quantity, :visible, :seller_id, :created_at, :updated_at
json.url item_url(item, format: :json)
