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

ActiveRecord::Schema.define(version: 20170129142834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "billing_address"
    t.string   "phone_number"
    t.string   "vat_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.string   "country"
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity"
    t.index ["order_id"], name: "index_order_details_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_details_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "company_id"
    t.text     "observations"
    t.float    "total_price_ht"
    t.boolean  "first_order"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "shipping_address_id"
    t.index ["company_id"], name: "index_orders_on_company_id", using: :btree
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "designation"
    t.float    "unit_price"
    t.text     "features"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.integer "company_id"
    t.string  "designation"
    t.string  "country"
    t.index ["company_id"], name: "index_shipping_addresses_on_company_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "companies", "users"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "shipping_addresses"
  add_foreign_key "shipping_addresses", "companies"
end
