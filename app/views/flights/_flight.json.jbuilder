json.extract! flight, :id, :flight_number, :origin_airport, :destination_airport, :departure_date, :departure_time, :flight_capacity, :flight_price, :created_at, :updated_at
json.url flight_url(flight, format: :json)
