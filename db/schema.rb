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

ActiveRecord::Schema[7.0].define(version: 2024_03_06_212008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "country_code"
    t.string "line1"
    t.string "line2"
    t.string "zipcode"
    t.boolean "is_residential"
    t.string "first_name"
    t.string "phone_number"
    t.string "email"
    t.string "state"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "formatted_address"
    t.string "google_address_components"
    t.string "state_code"
    t.string "last_name"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "account_number"
    t.string "bank_code"
    t.string "bank_name"
    t.string "benefactor_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "colour"
    t.boolean "is_sold"
    t.datetime "sold_at"
    t.string "condition"
    t.float "price"
    t.string "department"
    t.string "category"
    t.string "sub_category"
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "colour"
    t.boolean "is_sold"
    t.datetime "sold_at"
    t.string "condition"
    t.decimal "price", precision: 10, scale: 2
    t.string "department"
    t.string "category"
    t.string "subcategory"
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.text "description"
    t.string "location_state"
    t.string "location_country"
    t.integer "addresses_id"
    t.string "sender_address"
    t.index ["addresses_id"], name: "index_listings_on_addresses_id"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "buyer_id"
    t.integer "seller_id"
    t.integer "listing_id"
    t.string "status"
    t.integer "listing_price"
    t.integer "shipping_paid"
    t.integer "service_fee"
    t.integer "order_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender_address"
    t.string "buyer_address"
    t.string "terminal_rate_id"
    t.string "terminal_shipment_id"
    t.boolean "is_fulfilled"
    t.string "terminal_carrier_tracking_url"
    t.string "terminal_tracking_url"
    t.string "carrier"
  end

  create_table "refunds", force: :cascade do |t|
    t.text "description"
    t.boolean "resolved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "order_id"
    t.index ["order_id"], name: "index_refunds_on_order_id"
    t.index ["user_id"], name: "index_refunds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "address_id"
    t.json "default_address"
    t.integer "default_address_id"
    t.string "username"
    t.string "phone_number"
    t.index ["address_id"], name: "index_users_on_address_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "webhooks", force: :cascade do |t|
    t.string "source"
    t.jsonb "data"
    t.string "message"
    t.string "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_accounts", "users"
  add_foreign_key "listings", "addresses", column: "addresses_id"
  add_foreign_key "refunds", "orders"
  add_foreign_key "refunds", "users"
end
