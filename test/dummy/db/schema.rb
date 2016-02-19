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

ActiveRecord::Schema.define(version: 20160219034735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dhanvantri_core_availables", force: :cascade do |t|
    t.integer  "dhanvantri_core_doctor_id"
    t.integer  "week_day"
    t.float    "time_from"
    t.float    "time_to"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "dhanvantri_core_availables", ["dhanvantri_core_doctor_id"], name: "index_dhanvantri_core_availables_on_dhanvantri_core_doctor_id", using: :btree

  create_table "dhanvantri_core_branches", force: :cascade do |t|
    t.integer  "dhanvantri_core_category_id"
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "dhanvantri_core_branches", ["dhanvantri_core_category_id"], name: "index_dhanvantri_core_branches_on_dhanvantri_core_category_id", using: :btree

  create_table "dhanvantri_core_categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dhanvantri_core_doctors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender"
    t.string   "avatar"
    t.text     "specializations"
    t.integer  "year_of_experience"
    t.string   "clinic"
    t.integer  "consultation_fee"
    t.integer  "consultation_type"
    t.string   "addr_street"
    t.string   "addr_area"
    t.string   "addr_city"
    t.string   "addr_state"
    t.string   "phone_number"
    t.text     "description"
    t.text     "memberships"
    t.text     "awards"
    t.string   "registration_at"
    t.integer  "registration_year"
    t.float    "rate"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "google_plus"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "dhanvantri_core_doctors_services", force: :cascade do |t|
    t.integer  "dhanvantri_core_doctor_id"
    t.integer  "dhanvantri_core_service_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "dhanvantri_core_educations", force: :cascade do |t|
    t.integer  "dhanvantri_core_doctor_id"
    t.string   "certification"
    t.string   "college"
    t.integer  "year"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "dhanvantri_core_educations", ["dhanvantri_core_doctor_id"], name: "index_dhanvantri_core_educations_on_dhanvantri_core_doctor_id", using: :btree

  create_table "dhanvantri_core_experiences", force: :cascade do |t|
    t.integer  "dhanvantri_core_doctor_id"
    t.string   "position"
    t.string   "company"
    t.integer  "year_from"
    t.integer  "year_to"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "dhanvantri_core_experiences", ["dhanvantri_core_doctor_id"], name: "index_dhanvantri_core_experiences_on_dhanvantri_core_doctor_id", using: :btree

  create_table "dhanvantri_core_services", force: :cascade do |t|
    t.integer  "dhanvantri_core_branch_id"
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "dhanvantri_core_services", ["dhanvantri_core_branch_id"], name: "index_dhanvantri_core_services_on_dhanvantri_core_branch_id", using: :btree

  add_foreign_key "dhanvantri_core_availables", "dhanvantri_core_doctors"
  add_foreign_key "dhanvantri_core_branches", "dhanvantri_core_categories"
  add_foreign_key "dhanvantri_core_doctors_services", "dhanvantri_core_doctors"
  add_foreign_key "dhanvantri_core_doctors_services", "dhanvantri_core_services"
  add_foreign_key "dhanvantri_core_educations", "dhanvantri_core_doctors"
  add_foreign_key "dhanvantri_core_experiences", "dhanvantri_core_doctors"
  add_foreign_key "dhanvantri_core_services", "dhanvantri_core_branches"
end
