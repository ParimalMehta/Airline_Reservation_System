class CreateAirports < ActiveRecord::Migration[6.1]
  def change
    create_table :airports do |t|
      t.string :airport_place

      t.timestamps
    end
    add_index :airports, :airport_place, unique: true
  end
end
