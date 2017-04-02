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

ActiveRecord::Schema.define(version: 20170402195211) do

  create_table "bedrooms", force: :cascade do |t|
    t.integer  "cost_id"
    t.string   "name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "reservation_id"
    t.string   "state",          default: "Activo"
    t.index ["cost_id"], name: "index_bedrooms_on_cost_id"
    t.index ["reservation_id"], name: "index_bedrooms_on_reservation_id"
  end

  create_table "costs", force: :cascade do |t|
    t.string   "type_service"
    t.integer  "value"
    t.string   "category"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "debts", force: :cascade do |t|
    t.integer  "reservation_id"
    t.string   "value"
    t.string   "reason"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "state",          default: "Pendiente"
    t.index ["reservation_id"], name: "index_debts_on_reservation_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "cover"
    t.integer  "bedroom_id"
    t.integer  "cost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bedroom_id"], name: "index_images_on_bedroom_id"
    t.index ["cost_id"], name: "index_images_on_cost_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "reservation_id"
    t.integer  "value"
    t.string   "reason"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["reservation_id"], name: "index_payments_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "bedroom_id"
    t.integer  "user_id"
    t.integer  "quantity_days"
    t.string   "client_name"
    t.string   "identification_card"
    t.string   "phone"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.datetime "admission_date"
    t.datetime "departure_date"
    t.string   "state",               default: "Activo"
    t.index ["bedroom_id"], name: "index_reservations_on_bedroom_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
