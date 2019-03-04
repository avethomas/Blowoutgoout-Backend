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

ActiveRecord::Schema.define(version: 2019_12_18_030571) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.bigint "schedule_id"
    t.time "time_from"
    t.time "time_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_availabilities_on_schedule_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "stylist_id"
    t.bigint "service_id"
    t.time "time_from"
    t.time "time_to"
    t.decimal "fee", default: "0.0"
    t.decimal "service_lat"
    t.decimal "service_long"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_bookings_on_client_id"
    t.index ["service_id"], name: "index_bookings_on_service_id"
    t.index ["stylist_id"], name: "index_bookings_on_stylist_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "facebook_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "stylist_id"
    t.bigint "service_type_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_type_id"], name: "index_schedules_on_service_type_id"
    t.index ["stylist_id"], name: "index_schedules_on_stylist_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_type_id"
    t.bigint "stylist_id"
    t.decimal "amount", precision: 10, scale: 2
    t.integer "status", default: 1
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
    t.index ["stylist_id"], name: "index_services_on_stylist_id"
  end

  create_table "stylists", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "description"
    t.string "phone"
    t.integer "welcome_kit", default: 0
    t.integer "service_type", default: 1
    t.integer "register_by"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.integer "radius"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stylists_on_user_id"
  end

  create_table "user_services", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "comments"
    t.bigint "user_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_user_services_on_service_id"
    t.index ["user_id"], name: "index_user_services_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "role"
    t.string "gcm_id"
    t.string "device_type"
    t.string "device_id"
    t.integer "status", default: 1
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "availabilities", "schedules"
  add_foreign_key "bookings", "clients"
  add_foreign_key "bookings", "services"
  add_foreign_key "bookings", "stylists"
  add_foreign_key "schedules", "service_types"
  add_foreign_key "schedules", "stylists"
  add_foreign_key "services", "service_types"
  add_foreign_key "services", "stylists"
end
