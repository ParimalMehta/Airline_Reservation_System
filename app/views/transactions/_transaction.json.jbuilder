json.extract! transaction, :id, :transaction_number, :total_cost, :transaction_date, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
