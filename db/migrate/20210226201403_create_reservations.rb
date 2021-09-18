class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :confirmation_number
      t.string :flight_class
      t.integer :number_of_seats

      t.timestamps
    end
    add_index :reservations, :confirmation_number, unique: true
  end
end
