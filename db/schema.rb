# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_16_054948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "external_number"
    t.string "country"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.integer "addressable_id"
    t.string "addressable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "carriers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "carrier_type"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_carriers_on_company_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "business_name"
    t.string "rfc"
    t.string "email"
    t.string "phone"
    t.string "contact"
    t.bigint "user_id", null: false
    t.string "fiscal_name"
    t.integer "company_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: false
    t.index ["company_type_id"], name: "index_companies_on_company_type_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "company_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "affiliation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.integer "driver_number"
    t.integer "status"
    t.bigint "carrier_id", null: false
    t.string "licence_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrier_id"], name: "index_drivers_on_carrier_id"
  end

  create_table "fiscal_infos", force: :cascade do |t|
    t.string "ri"
    t.string "account_statement"
    t.string "proof_of_address"
    t.string "incorporation_act"
    t.datetime "start_of_operation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.string "fiscal_infoable_type"
    t.integer "fiscal_infoable_id"
    t.index ["company_id"], name: "index_fiscal_infos_on_company_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "uid"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "sale_concepts", force: :cascade do |t|
    t.bigint "sale_id", null: false
    t.string "unit_price"
    t.string "total"
    t.string "amount"
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_sale_concepts_on_product_id"
    t.index ["sale_id"], name: "index_sale_concepts_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "seller_id"
    t.integer "buyer_id"
    t.decimal "total"
    t.integer "status"
    t.string "sale_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["buyer_id"], name: "index_sales_on_buyer_id"
    t.index ["company_id"], name: "index_sales_on_company_id"
    t.index ["seller_id"], name: "index_sales_on_seller_id"
  end

  create_table "shipment_carriers", force: :cascade do |t|
    t.bigint "carrier_id", null: false
    t.bigint "shipment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrier_id"], name: "index_shipment_carriers_on_carrier_id"
    t.index ["shipment_id"], name: "index_shipment_carriers_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.bigint "sale_id", null: false
    t.bigint "user_id", null: false
    t.bigint "client_id", null: false
    t.text "instructions"
    t.integer "status"
    t.integer "total_products"
    t.integer "sale_number"
    t.datetime "issued_at"
    t.datetime "shiped_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_shipments_on_client_id"
    t.index ["sale_id"], name: "index_shipments_on_sale_id"
    t.index ["user_id"], name: "index_shipments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.integer "role", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carriers", "companies"
  add_foreign_key "companies", "users"
  add_foreign_key "drivers", "carriers"
  add_foreign_key "fiscal_infos", "companies"
  add_foreign_key "products", "companies"
  add_foreign_key "sale_concepts", "products"
  add_foreign_key "sale_concepts", "sales"
  add_foreign_key "sales", "companies"
  add_foreign_key "shipment_carriers", "carriers"
  add_foreign_key "shipment_carriers", "shipments"
  add_foreign_key "shipments", "clients"
  add_foreign_key "shipments", "sales"
  add_foreign_key "shipments", "users"
end
