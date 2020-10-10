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

ActiveRecord::Schema.define(version: 2020_10_10_190307) do

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
    t.string "active"
    t.string "contact"
    t.bigint "user_id", null: false
    t.string "fiscal_name"
    t.integer "company_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "fiscal_infos", force: :cascade do |t|
    t.string "ri"
    t.string "account_statement"
    t.string "proof_of_address"
    t.string "incorporation_act"
    t.datetime "start_of_operation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
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

  create_table "purchase_concepts", force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.string "unit_price"
    t.string "total"
    t.string "amount"
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_purchase_concepts_on_product_id"
    t.index ["purchase_id"], name: "index_purchase_concepts_on_purchase_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "seller_id"
    t.integer "buyer_id"
    t.decimal "total"
    t.integer "status"
    t.string "purchase_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["buyer_id"], name: "index_purchases_on_buyer_id"
    t.index ["company_id"], name: "index_purchases_on_company_id"
    t.index ["seller_id"], name: "index_purchases_on_seller_id"
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

  add_foreign_key "companies", "users"
  add_foreign_key "fiscal_infos", "companies"
  add_foreign_key "products", "companies"
  add_foreign_key "purchase_concepts", "products"
  add_foreign_key "purchase_concepts", "purchases"
  add_foreign_key "purchases", "companies"
end
