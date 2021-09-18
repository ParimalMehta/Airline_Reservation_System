# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_03_221227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "adminpack"
  enable_extension "plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string "airport_place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["airport_place"], name: "index_airports_on_airport_place", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "feedback_response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "flight_id", null: false
    t.index ["flight_id"], name: "index_feedbacks_on_flight_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "flight_number"
    t.string "origin_airport"
    t.string "destination_airport"
    t.date "departure_date"
    t.time "departure_time"
    t.integer "flight_capacity"
    t.integer "flight_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flight_number"], name: "index_flights_on_flight_number", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.string "confirmation_number"
    t.string "flight_class"
    t.integer "number_of_seats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "flight_id", null: false
    t.index ["flight_id"], name: "index_reservations_on_flight_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "transaction_number"
    t.integer "total_cost"
    t.date "transaction_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "flight_id", null: false
    t.index ["flight_id"], name: "index_transactions_on_flight_id"
    t.index ["transaction_number"], name: "index_transactions_on_transaction_number", unique: true
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "phone_number"
    t.text "address"
    t.string "name_on_card"
    t.string "card_number"
    t.date "expiration_date"
    t.integer "cvv"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "feedbacks", "flights"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "reservations", "flights"
  add_foreign_key "reservations", "users"
  add_foreign_key "transactions", "flights"
  add_foreign_key "transactions", "users"
end
