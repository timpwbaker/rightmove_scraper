# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181117162329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.text "address"
    t.date "added_on"
    t.date "reduced_on"
    t.integer "rightmove_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_id"
    t.text "tags", default: [], array: true
    t.integer "bedrooms"
    t.string "agent"
    t.datetime "added_date"
    t.datetime "under_offer"
    t.boolean "delisted", default: false
    t.datetime "time_delisted"
    t.datetime "last_checked_sold_prices"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "listing_id"
    t.date "date"
    t.integer "amount"
    t.boolean "reduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_prices_on_listing_id"
  end

  create_table "sold_prices", force: :cascade do |t|
    t.bigint "listing_id"
    t.integer "year"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id", "year", "amount"], name: "index_sold_prices_on_listing_id_and_year_and_amount", unique: true
    t.index ["listing_id"], name: "index_sold_prices_on_listing_id"
  end

  add_foreign_key "prices", "listings"
  add_foreign_key "sold_prices", "listings"
end
