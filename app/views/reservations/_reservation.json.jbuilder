json.extract! reservation, :id, :confirmation_number, :flight_class, :number_of_seats, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
