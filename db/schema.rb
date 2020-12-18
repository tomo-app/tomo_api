# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_17_043607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.bigint "users_id", null: false
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_availabilities_on_users_id"
  end

  create_table "blocked_pairings", force: :cascade do |t|
    t.bigint "blocking_user_id"
    t.bigint "blocked_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blocked_user_id"], name: "index_blocked_pairings_on_blocked_user_id"
    t.index ["blocking_user_id"], name: "index_blocked_pairings_on_blocking_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pairings", force: :cascade do |t|
    t.datetime "date_time"
    t.boolean "cancelled?"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pairings_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pairing_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pairing_id"], name: "index_pairings_users_on_pairing_id"
    t.index ["user_id"], name: "index_pairings_users_on_user_id"
  end

  create_table "topic_translations", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "language_id", null: false
    t.text "translation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_topic_translations_on_language_id"
    t.index ["topic_id"], name: "index_topic_translations_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_languages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "language_id", null: false
    t.integer "fluency_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_user_languages_on_language_id"
    t.index ["user_id"], name: "index_user_languages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "availabilities", "users", column: "users_id"
  add_foreign_key "blocked_pairings", "users", column: "blocked_user_id"
  add_foreign_key "blocked_pairings", "users", column: "blocking_user_id"
  add_foreign_key "pairings_users", "users"
  add_foreign_key "pairings_users", "users", column: "pairing_id"
  add_foreign_key "topic_translations", "languages"
  add_foreign_key "topic_translations", "topics"
  add_foreign_key "user_languages", "languages"
  add_foreign_key "user_languages", "users"
end
