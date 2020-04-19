json.extract! inquiry, :id, :firstname, :lastname, :email, :message, :created_at, :updated_at
json.url inquiry_url(inquiry, format: :json)
