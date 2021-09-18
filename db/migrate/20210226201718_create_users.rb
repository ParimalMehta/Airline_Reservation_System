class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :phone_number
      t.text :address
      t.string :name_on_card
      t.string :card_number
      t.date :expiration_date
      t.integer :cvv
      t.boolean :admin

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
