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

  create_table "access_tokens", id: :integer, default: -> { "nextval('sq_access_tokens'::regclass)" }, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.datetime "expires_at"
    t.boolean "is_revoked", null: false
    t.integer "user_id"
    t.integer "client_id"
    t.text "request", null: false
    t.text "refresh"
    t.integer "grantor_id"
    t.index ["client_id"], name: "ix_access_tokens_grantee_id"
    t.index ["user_id"], name: "ix_access_tokens_grantor_id"
  end

  create_table "add_ons", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "add_ons_name", null: false
    t.text "period", null: false
    t.datetime "add_ons_start_date", null: false
    t.datetime "add_ons_end_date", null: false
    t.boolean "status", null: false
    t.float "price", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.text "exid", null: false
    t.text "invoice_item_id", null: false
  end

  create_table "apps", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.boolean "local_recording", default: false, null: false
    t.boolean "cloud_recording", default: false, null: false
    t.boolean "motion_detection", default: false, null: false
    t.boolean "watermark", default: false, null: false
  end

  create_table "archives", id: :integer, default: -> { "nextval('archive_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.text "exid", null: false
    t.text "title", null: false
    t.datetime "from_date", null: false
    t.datetime "to_date", null: false
    t.integer "status", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.integer "requested_by", null: false
    t.boolean "embed_time"
    t.boolean "public"
    t.integer "frames", default: 0
    t.string "url", limit: 255
    t.string "file_name", limit: 255
    t.string "type", limit: 255
    t.text "error_message"
  end

  create_table "billing", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "timelapse"
    t.integer "snapmail"
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
  end

  create_table "camera_activities", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.integer "camera_id", null: false
    t.integer "access_token_id"
    t.text "action", null: false
    t.datetime "done_at", null: false
    t.inet "ip"
    t.json "extra"
    t.text "camera_exid"
    t.text "name"
    t.index ["camera_id", "done_at"], name: "camera_activities_camera_id_done_at_index", unique: true
  end

  create_table "camera_endpoints", id: :serial, force: :cascade do |t|
    t.integer "camera_id"
    t.text "scheme", null: false
    t.text "host", null: false
    t.integer "port", null: false
    t.index ["camera_id", "scheme", "host", "port"], name: "camera_endpoints_camera_id_scheme_host_port_index", unique: true
  end

  create_table "camera_share_requests", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.integer "user_id", null: false
    t.string "key", limit: 100, null: false
    t.string "email", limit: 250, null: false
    t.integer "status", null: false
    t.string "rights", limit: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "message"
    t.index ["camera_id", "email", "status"], name: "camera_share_requests_camera_id_email_status_index", unique: true, where: "(status = '-1'::integer)"
    t.index ["camera_id", "email"], name: "camera_share_requests_camera_id_email_index"
    t.index ["key"], name: "camera_share_requests_key_index", unique: true
  end

  create_table "camera_shares", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.integer "user_id", null: false
    t.integer "sharer_id"
    t.string "kind", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "message"
    t.index ["camera_id", "user_id"], name: "camera_shares_camera_id_user_id_index", unique: true
    t.index ["camera_id"], name: "camera_shares_camera_id_index"
    t.index ["user_id"], name: "camera_shares_user_id_index"
  end

# Could not dump table "cameras" because of following StandardError
#   Unknown type 'geography(Point,4326)' for column 'location'

  create_table "clients", id: :integer, default: -> { "nextval('sq_clients'::regclass)" }, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.text "api_id", null: false
    t.text "callback_uris", array: true
    t.text "api_key"
    t.text "name"
    t.text "settings"
  end

  create_table "cloud_recordings", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.integer "frequency", null: false
    t.integer "storage_duration", null: false
    t.json "schedule"
    t.text "status"
    t.index ["camera_id"], name: "cloud_recordings_camera_id_index", unique: true
  end

  create_table "compares", id: :serial, force: :cascade do |t|
    t.string "exid", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.datetime "before_date", null: false
    t.datetime "after_date", null: false
    t.string "embed_code", limit: 255, null: false
    t.integer "camera_id", null: false
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "create_animation", default: false
    t.integer "status", default: 0, null: false
    t.integer "requested_by", null: false
    t.boolean "public", default: true
    t.index ["exid"], name: "compare_exid_unique_index", unique: true
  end

  create_table "countries", id: :integer, default: -> { "nextval('sq_countries'::regclass)" }, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.text "iso3166_a2", null: false
    t.text "name", null: false
    t.index ["iso3166_a2"], name: "country_code_unique_index", unique: true
  end

  create_table "licences", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "description", null: false
    t.integer "total_cameras", null: false
    t.integer "storage", null: false
    t.float "amount"
    t.boolean "paid", default: false, null: false
    t.boolean "vat", default: false, null: false
    t.integer "vat_number"
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.boolean "cancel_licence", default: false, null: false
    t.text "subscription_id"
    t.boolean "auto_renew", default: false, null: false
    t.datetime "auto_renew_at"
  end

  create_table "meta_datas", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "camera_id"
    t.text "action", null: false
    t.integer "process_id"
    t.json "extra"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "motion_detections", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.integer "frequency"
    t.integer "minPosition"
    t.integer "step"
    t.integer "min"
    t.integer "threshold"
    t.json "schedule"
    t.boolean "enabled", default: false
    t.boolean "alert_email", default: false
    t.integer "alert_interval_min"
    t.integer "sensitivity"
    t.integer "x1"
    t.integer "y1"
    t.integer "x2"
    t.integer "y2"
    t.text "emails", array: true
  end

  create_table "snapmail_cameras", id: :serial, force: :cascade do |t|
    t.integer "snapmail_id", null: false
    t.integer "camera_id", null: false
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snapmail_id", "camera_id"], name: "snapemail_camera_id_unique_index", unique: true
  end

  create_table "snapmails", id: :serial, force: :cascade do |t|
    t.string "exid", limit: 255, null: false
    t.text "subject", null: false
    t.text "recipients"
    t.text "message"
    t.string "notify_days", limit: 255
    t.string "notify_time", limit: 255, null: false
    t.boolean "is_public", default: false, null: false
    t.integer "user_id"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.text "timezone"
    t.boolean "is_paused", default: false, null: false
    t.index ["exid"], name: "exid_unique_index", unique: true
  end

  create_table "snapshot_extractors", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.datetime "from_date", null: false
    t.datetime "to_date", null: false
    t.integer "interval", null: false
    t.json "schedule", null: false
    t.integer "status", default: 0, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at"
    t.text "requestor"
    t.boolean "inject_to_cr", default: false
    t.boolean "create_mp4", default: false
    t.boolean "jpegs_to_dropbox", default: false
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
  end

  create_table "timelapse_recordings", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.integer "frequency", null: false
    t.integer "storage_duration"
    t.json "schedule"
    t.string "status", limit: 255, null: false
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timelapses", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.string "exid", limit: 255, null: false
    t.string "title", limit: 255, null: false
    t.integer "frequency", null: false
    t.integer "snapshot_count", default: 0
    t.string "resolution", limit: 255
    t.integer "status", null: false
    t.boolean "date_always", default: false
    t.datetime "from_datetime"
    t.boolean "time_always", default: false
    t.datetime "to_datetime"
    t.text "watermark_logo"
    t.string "watermark_position", limit: 255
    t.boolean "recreate_hls", default: false
    t.boolean "start_recreate_hls", default: false
    t.boolean "hls_created", default: false
    t.datetime "last_snapshot_at"
    t.datetime "inserted_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.json "extra"
    t.index ["exid"], name: "timelapse_exid_unique_index", unique: true
  end

  create_table "users", id: :integer, default: -> { "nextval('sq_users'::regclass)" }, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.text "firstname", null: false
    t.text "lastname", null: false
    t.text "username", null: false
    t.text "password", null: false
    t.integer "country_id"
    t.datetime "confirmed_at"
    t.text "email", null: false
    t.text "reset_token"
    t.datetime "token_expires_at"
    t.text "api_id"
    t.text "api_key"
    t.boolean "is_admin", default: false, null: false
    t.text "stripe_customer_id"
    t.text "billing_id"
    t.datetime "last_login_at"
    t.text "vat_number"
    t.integer "payment_method", default: 0
    t.text "insight_id"
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "telegram_username", limit: 255
    t.string "referral_url", limit: 255
    t.index ["country_id"], name: "ix_users_country_id"
    t.index ["email"], name: "user_email_unique_index", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "user_username_unique_index", unique: true
  end

  create_table "users_old", id: :integer, default: nil, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.text "firstname", null: false
    t.text "lastname", null: false
    t.text "username", null: false
    t.text "password", null: false
    t.integer "country_id"
    t.datetime "confirmed_at"
    t.text "email", null: false
    t.text "reset_token"
    t.datetime "token_expires_at"
    t.text "api_id"
    t.text "api_key"
    t.boolean "is_admin", default: false, null: false
    t.text "stripe_customer_id"
    t.text "billing_id"
    t.datetime "last_login_at"
    t.text "vat_number"
    t.integer "payment_method", default: 0
    t.text "insight_id"
  end

  create_table "vendor_models", id: :integer, default: -> { "nextval('sq_firmwares'::regclass)" }, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.integer "vendor_id", null: false
    t.text "name", null: false
    t.json "config1"
    t.text "exid", default: "", null: false
    t.text "jpg_url", default: "", null: false
    t.text "h264_url", default: ""
    t.text "mjpg_url", default: ""
    t.text "shape", default: ""
    t.text "resolution", default: ""
    t.text "official_url", default: ""
    t.text "audio_url", default: ""
    t.text "more_info", default: ""
    t.boolean "poe", default: false, null: false
    t.boolean "wifi", default: false, null: false
    t.boolean "onvif", default: false, null: false
    t.boolean "psia", default: false, null: false
    t.boolean "ptz", default: false, null: false
    t.boolean "infrared", default: false, null: false
    t.boolean "varifocal", default: false, null: false
    t.boolean "sd_card", default: false, null: false
    t.boolean "upnp", default: false, null: false
    t.boolean "audio_io", default: false, null: false
    t.boolean "discontinued", default: false, null: false
    t.text "username"
    t.text "password"
    t.integer "channel"
    t.string "mpeg4_url", default: ""
    t.string "mobile_url", default: ""
    t.string "lowres_url", default: ""
    t.index ["vendor_id"], name: "ix_firmwares_vendor_id"
  end

  create_table "vendors", id: :integer, default: -> { "nextval('sq_vendors'::regclass)" }, force: :cascade do |t|
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.text "exid", null: false
    t.text "known_macs", null: false, array: true
    t.text "name", null: false
  end

  create_table "webhooks", id: :serial, force: :cascade do |t|
    t.integer "camera_id", null: false
    t.integer "user_id", null: false
    t.text "url", null: false
    t.text "exid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "compares", "cameras", name: "compares_camera_id_fkey"
  add_foreign_key "compares", "users", column: "requested_by", name: "compares_requested_by_fkey"
  add_foreign_key "licences", "users", name: "licences_user_id_fkey"
  add_foreign_key "meta_datas", "cameras", name: "meta_datas_camera_id_fkey"
  add_foreign_key "meta_datas", "users", name: "meta_datas_user_id_fkey"
  add_foreign_key "snapmail_cameras", "cameras", name: "snapmail_cameras_camera_id_fkey"
  add_foreign_key "snapmail_cameras", "snapmails", name: "snapmail_cameras_snapmail_id_fkey"
  add_foreign_key "snapmails", "users", name: "snapmails_user_id_fkey"
  add_foreign_key "snapshot_extractors", "cameras", name: "snapshot_extractors_camera_id_fkey"
  add_foreign_key "timelapse_recordings", "cameras", name: "timelapse_recordings_camera_id_fkey"
  add_foreign_key "timelapses", "cameras", name: "timelapses_camera_id_fkey"
  add_foreign_key "timelapses", "users", name: "timelapses_user_id_fkey"
end
