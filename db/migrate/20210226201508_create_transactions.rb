class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_number
      t.integer :total_cost
      t.date :transaction_date

      t.timestamps
    end
    add_index :transactions, :transaction_number, unique: true
  end
end
