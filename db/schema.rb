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

ActiveRecord::Schema.define(version: 2018_10_26_174100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "encode_records", force: :cascade do |t|
    t.bigint "episode_id"
    t.boolean "success", default: false
    t.datetime "finished_at"
    t.bigint "initial_size"
    t.bigint "final_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_encode_records_on_episode_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.bigint "series_id"
    t.integer "episode_file_id"
    t.integer "season_number"
    t.integer "episode_number"
    t.text "title"
    t.date "air_date"
    t.boolean "has_file"
    t.integer "absolute_episode_number"
    t.integer "sonarr_id"
    t.text "path"
    t.bigint "size"
    t.date "date_added"
    t.string "audio"
    t.string "video"
    t.boolean "encoded", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["series_id"], name: "index_episodes_on_series_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "title"
    t.integer "sonarr_id"
    t.integer "season_count"
    t.integer "episode_count"
    t.bigint "size_on_disk"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "encode_records", "episodes"
  add_foreign_key "episodes", "series"
end
