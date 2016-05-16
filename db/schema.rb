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

ActiveRecord::Schema.define(version: 20160516195721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id"
    t.integer  "user_id"
    t.string   "name"
    t.json     "properties"
    t.datetime "time"
  end

  add_index "ahoy_events", ["name", "time"], name: "index_ahoy_events_on_name_and_time", using: :btree
  add_index "ahoy_events", ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name", using: :btree
  add_index "ahoy_events", ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "danish",     limit: 255
    t.string   "english",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["danish"], name: "index_categories_on_danish", unique: true, using: :btree
  add_index "categories", ["english"], name: "index_categories_on_english", unique: true, using: :btree

  create_table "categories_event_series", id: false, force: :cascade do |t|
    t.integer "event_series_id"
    t.integer "category_id"
  end

  add_index "categories_event_series", ["category_id"], name: "index_categories_event_series_on_category_id", using: :btree
  add_index "categories_event_series", ["event_series_id"], name: "index_categories_event_series_on_event_series_id", using: :btree

  create_table "categories_events", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "category_id"
  end

  add_index "categories_events", ["category_id"], name: "index_categories_events_on_category_id", using: :btree
  add_index "categories_events", ["event_id"], name: "index_categories_events_on_event_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text    "content"
    t.boolean "hidden"
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "event_series", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "price"
    t.boolean  "cancelled"
    t.integer  "user_id"
    t.integer  "location_id"
    t.boolean  "comments_enabled"
    t.string   "link"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rule"
    t.string   "days"
    t.date     "expiry"
    t.date     "start_date"
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "published",             default: true
    t.boolean  "expiring_warning_sent", default: false
    t.boolean  "expired_warning_sent",  default: false
  end

  create_table "event_series_categories", id: false, force: :cascade do |t|
    t.integer "event_series_id"
    t.integer "category_id"
  end

  add_index "event_series_categories", ["category_id"], name: "index_event_series_categories_on_category_id", using: :btree
  add_index "event_series_categories", ["event_series_id"], name: "index_event_series_categories_on_event_series_id", using: :btree

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
    t.boolean  "featured",                         default: false
    t.boolean  "published",                        default: true
  end

  add_index "events", ["event_series_id"], name: "index_events_on_event_series_id", using: :btree
  add_index "events", ["featured"], name: "index_events_on_featured", using: :btree
  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.string  "street_address", limit: 255
    t.string  "postcode",       limit: 255
    t.string  "town",           limit: 255
    t.text    "description"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string  "link"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "featured"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["featured"], name: "index_posts_on_featured", using: :btree

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

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
    t.text     "description"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.string   "visit_token"
    t.string   "visitor_token"
    t.text     "user_agent"
    t.text     "referrer"
    t.text     "landing_page"
    t.integer  "user_id"
    t.string   "referring_domain"
    t.string   "search_keyword"
    t.string   "browser"
    t.string   "os"
    t.string   "device_type"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree
  add_index "visits", ["visit_token"], name: "index_visits_on_visit_token", unique: true, using: :btree

end
