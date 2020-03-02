# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_02_153429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_sets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "difficulty"
    t.bigint "language_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_card_sets_on_language_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.text "question"
    t.string "correct_answer"
    t.string "answer_1"
    t.string "answer_2"
    t.string "answer_3"
    t.bigint "card_set_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_set_id"], name: "index_flashcards_on_card_set_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_answers", force: :cascade do |t|
    t.boolean "correct"
    t.bigint "user_set_id", null: false
    t.bigint "flashcard_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flashcard_id"], name: "index_user_answers_on_flashcard_id"
    t.index ["user_set_id"], name: "index_user_answers_on_user_set_id"
  end

  create_table "user_sets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "card_set_id", null: false
    t.boolean "completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_set_id"], name: "index_user_sets_on_card_set_id"
    t.index ["user_id"], name: "index_user_sets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.text "bio"
    t.integer "points"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "card_sets", "languages"
  add_foreign_key "flashcards", "card_sets"
  add_foreign_key "user_answers", "flashcards"
  add_foreign_key "user_answers", "user_sets"
  add_foreign_key "user_sets", "card_sets"
  add_foreign_key "user_sets", "users"
end
