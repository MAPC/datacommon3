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

ActiveRecord::Schema.define(version: 20151105172912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "auth_user", force: true do |t|
    t.string   "username",          limit: 30,                  null: false
    t.string   "first_name",        limit: 30,                  null: false
    t.string   "last_name",         limit: 30,                  null: false
    t.string   "email",             limit: 75,                  null: false
    t.string   "password_digest",   limit: 128,                 null: false
    t.boolean  "is_staff",                      default: false, null: false
    t.boolean  "is_active",                     default: false, null: false
    t.boolean  "is_superuser",                  default: false, null: false
    t.datetime "last_login"
    t.datetime "created_at",                                    null: false
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "activation_token"
    t.string   "reset_token"
    t.integer  "institution_id"
  end

  add_index "auth_user", ["institution_id"], name: "index_auth_user_on_institution_id", using: :btree
  add_index "auth_user", ["remember_digest"], name: "index_auth_user_on_remember_digest", using: :btree
  add_index "auth_user", ["username"], name: "auth_user_username_key", unique: true, using: :btree

  create_table "brandings", force: true do |t|
    t.integer "institution_id"
    t.string  "logo_url"
    t.string  "tagline"
    t.string  "map_gallery_intro"
    t.text    "logos",             default: "[]"
    t.string  "address"
    t.string  "phone_number"
    t.string  "email"
  end

  create_table "core_genericobjectrolemapping", force: true do |t|
    t.string  "subject",      limit: 100, null: false
    t.integer "object_ct_id",             null: false
    t.integer "object_id",                null: false
    t.integer "role_id",                  null: false
  end

  add_index "core_genericobjectrolemapping", ["object_ct_id"], name: "core_genericobjectrolemapping_object_ct_id", using: :btree
  add_index "core_genericobjectrolemapping", ["role_id"], name: "core_genericobjectrolemapping_role_id", using: :btree
  add_index "core_genericobjectrolemapping", ["subject", "object_ct_id", "object_id", "role_id"], name: "core_genericobjectrolemapping_subject_object_ct_id_object_i_key", unique: true, using: :btree

  create_table "institutions", force: true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.string   "subdomain"
    t.integer  "region_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "retina_dimensions"
  end

  create_table "institutions_logos", id: false, force: true do |t|
    t.integer "institution_id", null: false
    t.integer "logo_id",        null: false
  end

  add_index "institutions_logos", ["institution_id", "logo_id"], name: "index_institutions_logos_on_institution_id_and_logo_id", using: :btree
  add_index "institutions_logos", ["logo_id", "institution_id"], name: "index_institutions_logos_on_logo_id_and_institution_id", using: :btree

  create_table "logos", force: true do |t|
    t.string   "alt_text"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maps_contact", force: true do |t|
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
    t.boolean  "mapc_newsletter",             default: false, null: false
    t.boolean  "mbdc_newsletter",             default: false, null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "maps_contact", ["user_id"], name: "maps_contact_user_id", using: :btree

  create_table "mbdc_calendar", force: true do |t|
    t.integer  "year",                                     null: false
    t.integer  "month",                                    null: false
    t.string   "title",            limit: 100,             null: false
    t.text     "abstract",                                 null: false
    t.string   "pdf_page",         limit: 100,             null: false
    t.string   "thumbnail",        limit: 100,             null: false
    t.integer  "institution_id",               default: 1
    t.string   "map_file_name"
    t.string   "map_content_type"
    t.integer  "map_file_size"
    t.datetime "map_updated_at"
  end

  create_table "mbdc_calendar_sources", force: true do |t|
    t.integer "calendar_id",   null: false
    t.integer "datasource_id", null: false
  end

  add_index "mbdc_calendar_sources", ["calendar_id", "datasource_id"], name: "mbdc_calendar_sources_calendar_id_4b0d4bdf31ddc740_uniq", unique: true, using: :btree
  add_index "mbdc_calendar_sources", ["calendar_id"], name: "mbdc_calendar_sources_calendar_id", using: :btree
  add_index "mbdc_calendar_sources", ["datasource_id"], name: "mbdc_calendar_sources_datasource_id", using: :btree

  create_table "mbdc_calendar_topics", force: true do |t|
    t.integer "calendar_id", null: false
    t.integer "topic_id",    null: false
  end

  add_index "mbdc_calendar_topics", ["calendar_id", "topic_id"], name: "mbdc_calendar_topics_calendar_id_38f0752a22458442_uniq", unique: true, using: :btree
  add_index "mbdc_calendar_topics", ["calendar_id"], name: "mbdc_calendar_topics_calendar_id", using: :btree
  add_index "mbdc_calendar_topics", ["topic_id"], name: "mbdc_calendar_topics_topic_id", using: :btree

  create_table "mbdc_datasource", force: true do |t|
    t.string "title",       limit: 100, null: false
    t.string "slug",        limit: 50,  null: false
    t.string "url",         limit: 200
    t.text   "description"
  end

  add_index "mbdc_datasource", ["slug"], name: "mbdc_datasource_slug", using: :btree
  add_index "mbdc_datasource", ["slug"], name: "mbdc_datasource_slug_like", using: :btree

  create_table "mbdc_featured", force: true do |t|
    t.integer "visualization_id", null: false
    t.integer "order"
  end

  add_index "mbdc_featured", ["visualization_id"], name: "mbdc_featured_visualization_id", using: :btree

  create_table "mbdc_hero", force: true do |t|
    t.string   "title",               limit: 100,                  null: false
    t.string   "subtitle",            limit: 50,                   null: false
    t.string   "navtitle",            limit: 50
    t.string   "navsubtitle",         limit: 50
    t.text     "content"
    t.string   "image",               limit: 100
    t.integer  "order"
    t.boolean  "active",                                           null: false
    t.string   "content_markup_type", limit: 30,  default: "html", null: false
    t.text     "_content_rendered",                                null: false
    t.integer  "institution_id",                  default: 1
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "mbdc_topic", force: true do |t|
    t.string  "title",  limit: 100,                 null: false
    t.string  "slug",   limit: 50,                  null: false
    t.integer "order"
    t.boolean "active",             default: false, null: false
  end

  add_index "mbdc_topic", ["slug"], name: "mbdc_topic_slug", using: :btree
  add_index "mbdc_topic", ["slug"], name: "mbdc_topic_slug_like", using: :btree

  create_table "snapshots_regionalunit", force: true do |t|
    t.string   "unitid"
    t.string   "name",                                            null: false
    t.string   "slug",                                            null: false
    t.integer  "regiontype_id"
    t.geometry "geometry",                                        null: false
    t.text     "short_desc"
    t.string   "short_desc_markup_type",                          null: false
    t.text     "_short_desc_rendered",                            null: false
    t.string   "subunit_ids"
    t.integer  "institution_id",         default: 1
    t.string   "type",                   default: "municipality"
  end

  create_table "snapshots_visualization", force: true do |t|
    t.string   "title",                      limit: 100,                 null: false
    t.integer  "regiontype_id",                          default: 1,     null: false
    t.string   "sessionstate",               limit: 100,                 null: false
    t.string   "year",                       limit: 20
    t.boolean  "overviewmap",                            default: false, null: false
    t.string   "session_state_file_name"
    t.string   "session_state_content_type"
    t.integer  "session_state_file_size"
    t.datetime "session_state_updated_at"
    t.string   "type"
  end

  add_index "snapshots_visualization", ["regiontype_id"], name: "snapshots_visualization_regiontype_id", using: :btree

  create_table "snapshots_visualization_source", force: true do |t|
    t.integer "visualization_id", null: false
    t.integer "datasource_id",    null: false
  end

  create_table "snapshots_visualization_topics", force: true do |t|
    t.integer "visualization_id", null: false
    t.integer "topic_id",         null: false
  end

  add_index "snapshots_visualization_topics", ["topic_id"], name: "snapshots_visualization_topics_topic_id", using: :btree
  add_index "snapshots_visualization_topics", ["visualization_id", "topic_id"], name: "snapshots_visualization__visualization_id_34c1e30e30858e56_uniq", unique: true, using: :btree
  add_index "snapshots_visualization_topics", ["visualization_id"], name: "snapshots_visualization_topics_visualization_id", using: :btree

  create_table "weave_visualization", force: true do |t|
    t.string   "title",              limit: 100
    t.text     "abstract"
    t.integer  "owner_id",                                          null: false
    t.datetime "updated_at",                                        null: false
    t.text     "sessionstate",                                      null: false
    t.string   "year",               limit: 50
    t.integer  "original_id"
    t.integer  "featured"
    t.integer  "institution_id",                 default: 1
    t.string   "permission",                     default: "public"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "weave_visualization", ["original_id"], name: "weave_visualization_original_id", using: :btree
  add_index "weave_visualization", ["owner_id"], name: "weave_visualization_owner_id", using: :btree

  create_table "weave_visualization_datasources", force: true do |t|
    t.integer "visualization_id", null: false
    t.integer "datasource_id",    null: false
  end

  add_index "weave_visualization_datasources", ["datasource_id"], name: "weave_visualization_datasources_datasource_id", using: :btree
  add_index "weave_visualization_datasources", ["visualization_id", "datasource_id"], name: "weave_visualization_data_visualization_id_7910f94c368bebdd_uniq", unique: true, using: :btree
  add_index "weave_visualization_datasources", ["visualization_id"], name: "weave_visualization_datasources_visualization_id", using: :btree

  create_table "weave_visualization_topics", force: true do |t|
    t.integer "visualization_id", null: false
    t.integer "topic_id",         null: false
  end

  add_index "weave_visualization_topics", ["topic_id"], name: "weave_visualization_topics_topic_id", using: :btree
  add_index "weave_visualization_topics", ["visualization_id", "topic_id"], name: "weave_visualization_topi_visualization_id_1f3c9f406802bc09_uniq", unique: true, using: :btree
  add_index "weave_visualization_topics", ["visualization_id"], name: "weave_visualization_topics_visualization_id", using: :btree

end
