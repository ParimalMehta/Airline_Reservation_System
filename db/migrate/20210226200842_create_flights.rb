class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.string :flight_number
      t.string :origin_airport
      t.string :destination_airport
      t.date :departure_date
      t.time :departure_time
      t.integer :flight_capacity
      t.integer :flight_price

      t.timestamps
    end
    add_index :flights, :flight_number, unique: true
  end
end
