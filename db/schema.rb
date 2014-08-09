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

ActiveRecord::Schema.define(version: 20140723202134) do

  create_table "categories", force: true do |t|
    t.string   "key"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_events", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "category_id"
  end

  add_index "categories_events", ["category_id"], name: "index_categories_events_on_category_id"
  add_index "categories_events", ["event_id"], name: "index_categories_events_on_event_id"

  create_table "comments", force: true do |t|
    t.text    "content"
    t.boolean "hidden"
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "short_description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "price"
    t.boolean  "cancelled"
    t.text     "long_description"
    t.integer  "user_id"
    t.integer  "location_id"
    t.boolean  "comments_enabled",  default: false
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "locations", force: true do |t|
    t.string  "name"
    t.string  "street_address"
    t.string  "postcode"
    t.string  "town"
    t.text    "description"
    t.decimal "latitude"
    t.decimal "longitude"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "is_admin",               default: false
    t.boolean  "is_anonymous",           default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
