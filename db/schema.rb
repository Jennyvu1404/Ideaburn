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

ActiveRecord::Schema.define(version: 20160315054358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entrepreneurs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.date     "dob"
    t.integer  "entrepreneur_type"
    t.boolean  "gender"
    t.integer  "profession_type"
    t.string   "profession_company"
    t.integer  "profession_skill"
    t.integer  "profession_experience"
    t.string   "graduation"
    t.string   "university"
    t.string   "mobile"
    t.string   "address"
    t.string   "website"
    t.string   "email_second"
    t.text     "about"
    t.text     "inspire_quote"
    t.string   "linkedin"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "skype"
  end

  add_index "entrepreneurs", ["user_id"], name: "index_entrepreneurs_on_user_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.string   "attachment"
    t.integer  "views"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "investors", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "founded"
    t.integer  "category"
    t.string   "website"
    t.text     "mission"
    t.text     "work"
    t.integer  "register_under"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "description"
    t.string   "team_name"
    t.integer  "team_designation"
    t.date     "team_joined_date"
    t.string   "team_email_id"
    t.string   "team_mobile"
    t.string   "team_linkedin"
    t.string   "team_skype"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "startup_name"
    t.string   "startup_logo"
    t.string   "funding_round"
    t.string   "funding_amount"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "ios_app"
    t.string   "adroid_app"
    t.string   "windows_app"
    t.string   "business_line"
    t.integer  "investor_type"
    t.string   "portfolio_website"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "gender"
    t.date     "dob"
    t.string   "website_secondary"
    t.string   "skype"
  end

  add_index "investors", ["user_id"], name: "index_investors_on_user_id", using: :btree

  create_table "startups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "founded"
    t.integer  "bussines_category"
    t.string   "website"
    t.string   "strength"
    t.text     "mission"
    t.text     "work"
    t.integer  "register_under"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "reg_company_name"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "linkedin"
    t.string   "ios_app"
    t.string   "adroid_app"
    t.string   "window_app"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "team_name"
    t.integer  "team_designation"
    t.date     "team_joined_date"
    t.string   "team_email_d"
    t.string   "team_mobile"
    t.string   "team_linkedin"
    t.string   "team_skype"
    t.integer  "funding_type"
    t.string   "funding_amout"
    t.string   "funding_date"
    t.string   "funding_by_investor"
    t.text     "about"
  end

  add_index "startups", ["user_id"], name: "index_startups_on_user_id", using: :btree

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.integer  "user_type"
    t.string   "country"
    t.string   "city"
    t.string   "region"
    t.string   "photo"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "entrepreneurs", "users"
  add_foreign_key "investors", "users"
  add_foreign_key "startups", "users"
end
