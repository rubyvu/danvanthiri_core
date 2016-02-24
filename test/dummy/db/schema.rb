# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160223081518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "danvanthiri_core_appointments", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "booktime"
    t.integer  "status",     default: 0
    t.integer  "fee"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "danvanthiri_core_appointments", ["doctor_id"], name: "index_danvanthiri_core_appointments_on_doctor_id", using: :btree
  add_index "danvanthiri_core_appointments", ["patient_id"], name: "index_danvanthiri_core_appointments_on_patient_id", using: :btree

  create_table "danvanthiri_core_availables", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "week_day"
    t.float    "time_from"
    t.float    "time_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "danvanthiri_core_availables", ["doctor_id"], name: "index_danvanthiri_core_availables_on_doctor_id", using: :btree

  create_table "danvanthiri_core_branches", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "danvanthiri_core_branches", ["category_id"], name: "index_danvanthiri_core_branches_on_category_id", using: :btree

  create_table "danvanthiri_core_branches_doctors", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "branch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "danvanthiri_core_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "danvanthiri_core_doctors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender"
    t.string   "avatar"
    t.integer  "year_of_experience"
    t.integer  "consultation_fee"
    t.string   "addr_street"
    t.string   "addr_area"
    t.string   "addr_city"
    t.string   "addr_state"
    t.string   "phone_number"
    t.text     "about"
    t.text     "certification"
    t.string   "registration"
    t.float    "rate"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "danvanthiri_core_patients", force: :cascade do |t|
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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.integer  "gender"
    t.datetime "date_of_birth"
    t.string   "addr_street"
    t.string   "addr_area"
    t.string   "addr_city"
    t.string   "addr_state"
    t.string   "slug"
    t.string   "auth_token"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "danvanthiri_core_patients", ["email"], name: "index_danvanthiri_core_patients_on_email", unique: true, using: :btree
  add_index "danvanthiri_core_patients", ["reset_password_token"], name: "index_danvanthiri_core_patients_on_reset_password_token", unique: true, using: :btree

end
