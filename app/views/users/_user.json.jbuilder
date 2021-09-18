json.extract! user, :id, :email, :name, :phone_number, :address, :name_on_card, :card_number, :expiration_date, :cvv, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
