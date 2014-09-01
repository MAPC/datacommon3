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

ActiveRecord::Schema.define(version: 20140901170947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_sources", force: true do |t|
    t.string "title",       limit: 100, null: false
    t.string "slug",        limit: 50,  null: false
    t.string "url",         limit: 200
    t.text   "description"
  end

  add_index "data_sources", ["slug"], name: "data_sources_slug", using: :btree
  add_index "data_sources", ["slug"], name: "data_sources_slug_like", using: :btree

  create_table "dynamic_visualizations", force: true do |t|
    t.string  "title",         limit: 100,             null: false
    t.integer "regiontype_id",             default: 1, null: false
    t.string  "sessionstate",  limit: 100,             null: false
    t.string  "year",          limit: 20
    t.boolean "overviewmap",                           null: false
  end

  add_index "dynamic_visualizations", ["regiontype_id"], name: "dynamic_visualizations_regiontype_id", using: :btree

  create_table "featured_visualizations", force: true do |t|
    t.integer "visualization_id", null: false
    t.integer "order"
  end

  add_index "featured_visualizations", ["visualization_id"], name: "featured_visualizations_visualization_id", using: :btree

  create_table "heros", force: true do |t|
    t.string  "title",               limit: 100, null: false
    t.string  "subtitle",            limit: 50,  null: false
    t.string  "navtitle",            limit: 50
    t.string  "navsubtitle",         limit: 50
    t.text    "content"
    t.string  "image",               limit: 100, null: false
    t.integer "order"
    t.boolean "active",                          null: false
    t.string  "content_markup_type", limit: 30,  null: false
    t.text    "_content_rendered",               null: false
  end

  create_table "issue_areas", force: true do |t|
    t.string  "title", limit: 100, null: false
    t.string  "slug",  limit: 50,  null: false
    t.integer "order"
  end

  add_index "issue_areas", ["slug"], name: "issue_areas_slug", using: :btree
  add_index "issue_areas", ["slug"], name: "issue_areas_slug_like", using: :btree

  create_table "static_maps", force: true do |t|
    t.integer "year",                  null: false
    t.integer "month",                 null: false
    t.string  "title",     limit: 100, null: false
    t.text    "abstract",              null: false
    t.string  "pdf_page",  limit: 100, null: false
    t.string  "thumbnail", limit: 100, null: false
  end

  create_table "users", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "organization"
    t.string   "position"
    t.string   "voice"
    t.string   "fax"
    t.string   "delivery"
    t.string   "city"
    t.string   "area"
    t.string   "zipcode"
    t.string   "country",         limit: 3
    t.string   "email",           limit: 75
    t.string   "website_url",     limit: 200
    t.boolean  "mapc_newsletter",             null: false
    t.boolean  "mbdc_newsletter",             null: false
    t.datetime "last_modified",               null: false
  end

  add_index "users", ["user_id"], name: "users_user_id", using: :btree

  create_table "visualizations", force: true do |t|
    t.string   "title",         limit: 100
    t.text     "abstract"
    t.integer  "owner_id",                  null: false
    t.datetime "last_modified",             null: false
    t.text     "sessionstate",              null: false
    t.string   "year",          limit: 50
    t.integer  "original_id"
    t.integer  "featured"
  end

  add_index "visualizations", ["original_id"], name: "visualizations_original_id", using: :btree
  add_index "visualizations", ["owner_id"], name: "visualizations_owner_id", using: :btree

end
