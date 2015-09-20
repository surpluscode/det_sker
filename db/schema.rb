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

ActiveRecord::Schema.define(version: 20150920200555) do

  create_table "categories", force: :cascade do |t|
    t.string   "danish",     limit: 255
    t.string   "english",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["danish"], name: "index_categories_on_danish", unique: true
  add_index "categories", ["english"], name: "index_categories_on_english", unique: true

  create_table "categories_event_series", id: false, force: :cascade do |t|
    t.integer "event_series_id"
    t.integer "category_id"
  end

  add_index "categories_event_series", ["category_id"], name: "index_categories_event_series_on_category_id"
  add_index "categories_event_series", ["event_series_id"], name: "index_categories_event_series_on_event_series_id"

  create_table "categories_events", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "category_id"
  end

  add_index "categories_events", ["category_id"], name: "index_categories_events_on_category_id"
  add_index "categories_events", ["event_id"], name: "index_categories_events_on_event_id"

  create_table "comments", force: :cascade do |t|
    t.text    "content"
    t.boolean "hidden"
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "event_series", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.text     "description"
    t.string   "price",                limit: 255
    t.boolean  "cancelled"
    t.integer  "user_id"
    t.integer  "location_id"
    t.boolean  "comments_enabled"
    t.string   "link",                 limit: 255
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rule",                 limit: 255
    t.string   "days",                 limit: 255
    t.date     "expiry"
    t.date     "start_date"
    t.time     "start_time"
    t.time     "end_time"
  end

  create_table "event_series_categories", id: false, force: :cascade do |t|
    t.integer "event_series_id"
    t.integer "category_id"
  end

  add_index "event_series_categories", ["category_id"], name: "index_event_series_categories_on_category_id"
  add_index "event_series_categories", ["event_series_id"], name: "index_event_series_categories_on_event_series_id"

  create_table "events", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.text     "short_description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "price",                limit: 255
    t.boolean  "cancelled"
    t.text     "long_description"
    t.integer  "user_id"
    t.integer  "location_id"
    t.boolean  "comments_enabled",                 default: false
    t.string   "link",                 limit: 255
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "event_series_id"
  end

  add_index "events", ["event_series_id"], name: "index_events_on_event_series_id"
  add_index "events", ["location_id"], name: "index_events_on_location_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "locations", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.string  "street_address", limit: 255
    t.string  "postcode",       limit: 255
    t.string  "town",           limit: 255
    t.text    "description"
    t.decimal "latitude"
    t.decimal "longitude"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "featured"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.boolean  "is_admin",                           default: false
    t.boolean  "is_anonymous",                       default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
