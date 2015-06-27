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

ActiveRecord::Schema.define(version: 20150627192310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "league_point_categories", force: :cascade do |t|
    t.integer  "league_id"
    t.integer  "point_category_id"
    t.string   "group"
    t.string   "title"
    t.decimal  "value"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "league_point_categories", ["league_id"], name: "index_league_point_categories_on_league_id", using: :btree
  add_index "league_point_categories", ["point_category_id"], name: "index_league_point_categories_on_point_category_id", using: :btree

  create_table "league_positions", force: :cascade do |t|
    t.integer  "league_id"
    t.integer  "position_id"
    t.string   "title"
    t.integer  "count"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "league_positions", ["league_id"], name: "index_league_positions_on_league_id", using: :btree
  add_index "league_positions", ["position_id"], name: "index_league_positions_on_position_id", using: :btree

  create_table "league_templates", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "title"
    t.integer  "league_template_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "leagues", ["league_template_id"], name: "index_leagues_on_league_template_id", using: :btree

  create_table "point_categories", force: :cascade do |t|
    t.integer  "league_template_id"
    t.string   "group"
    t.string   "title"
    t.decimal  "suggested_value"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "point_categories", ["league_template_id"], name: "index_point_categories_on_league_template_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.integer  "league_template_id"
    t.string   "title"
    t.integer  "suggested_count"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "positions", ["league_template_id"], name: "index_positions_on_league_template_id", using: :btree

  add_foreign_key "league_point_categories", "leagues"
  add_foreign_key "league_point_categories", "point_categories"
  add_foreign_key "league_positions", "leagues"
  add_foreign_key "league_positions", "positions"
  add_foreign_key "leagues", "league_templates"
  add_foreign_key "point_categories", "league_templates"
  add_foreign_key "positions", "league_templates"
end
