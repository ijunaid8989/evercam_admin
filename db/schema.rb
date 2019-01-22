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

ActiveRecord::Schema.define(version: 2019_01_03_060441) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "access_rights", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "token_id", null: false
    t.text "right", null: false
    t.integer "camera_id"
    t.integer "grantor_id"
    t.integer "status", default: 1, null: false
    t.integer "snapshot_id"
    t.integer "account_id"
    t.string "scope", limit: 100
    t.index ["camera_id"], name: "access_rights_camera_id_index"
    t.index ["token_id", "camera_id", "right"], name: "access_rights_token_id_camera_id_right_index"
    t.index ["token_id"], name: "access_rights_token_id_index"
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
  end

end
