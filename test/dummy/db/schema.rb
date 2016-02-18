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

ActiveRecord::Schema.define(version: 20160218080237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
