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

ActiveRecord::Schema.define(version: 2019_08_02_232246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "name", default: ""
    t.string "description", default: ""
    t.string "image", default: ""
    t.string "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_movies_on_name"
    t.index ["status"], name: "index_movies_on_status"
    t.index ["user_id"], name: "index_movies_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "schedule"
    t.string "status"
    t.bigint "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_schedules_on_movie_id"
    t.index ["schedule"], name: "index_schedules_on_schedule"
    t.index ["status"], name: "index_schedules_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", default: "", null: false
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "phone", default: "", null: false
    t.string "avatar", default: "", null: false
    t.string "status", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["status"], name: "index_users_on_status"
  end

  add_foreign_key "movies", "users"
  add_foreign_key "schedules", "movies"
end
