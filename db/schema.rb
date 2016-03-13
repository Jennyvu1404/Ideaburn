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

ActiveRecord::Schema.define(version: 20160310203631) do

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
  end

  add_index "entrepreneurs", ["user_id"], name: "index_entrepreneurs_on_user_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.string   "attachment"
    t.integer  "views",       default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
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
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "investors", ["user_id"], name: "index_investors_on_user_id", using: :btree

  create_table "startups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "founded"
    t.integer  "category"
    t.string   "website"
    t.datetime "strength"
    t.text     "mission"
    t.text     "work"
    t.integer  "register_under"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
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
    t.string   "home_town"
    t.string   "photo"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "entrepreneurs", "users"
  add_foreign_key "investors", "users"
  add_foreign_key "startups", "users"
end
