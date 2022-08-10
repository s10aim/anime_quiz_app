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

ActiveRecord::Schema[7.0].define(version: 2022_08_04_060529) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "animes", comment: "アニメ", force: :cascade do |t|
    t.string "title", null: false, comment: "タイトル"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_animes_on_title", unique: true
  end

  create_table "choices", comment: "選択肢", force: :cascade do |t|
    t.string "body", null: false, comment: "本文"
    t.boolean "is_correct", comment: "正解の選択肢か"
    t.bigint "quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id", "body"], name: "index_choices_on_quiz_id_and_body", unique: true
    t.index ["quiz_id"], name: "index_choices_on_quiz_id"
  end

  create_table "packages", comment: "パッケージ", force: :cascade do |t|
    t.integer "category", null: false, comment: "カテゴリー"
    t.string "guest_id", comment: "ゲストID"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_at", precision: nil, default: -> { "now()" }, null: false, comment: "開始時刻"
    t.datetime "finished_at", precision: nil, comment: "終了時刻"
    t.integer "quiz_score", comment: "クイズスコア"
    t.integer "ranking_score", comment: "ランキングスコア"
    t.integer "anime_list_count", comment: "アニメリストの数"
    t.bigint "anime_id"
    t.index ["anime_id"], name: "index_packages_on_anime_id"
    t.index ["user_id"], name: "index_packages_on_user_id"
  end

  create_table "quiz_packages", comment: "クイズパッケージ", force: :cascade do |t|
    t.integer "position", null: false, comment: "表示順位"
    t.bigint "quiz_id", null: false
    t.bigint "choice_id"
    t.bigint "package_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_quiz_packages_on_choice_id"
    t.index ["package_id", "position"], name: "index_quiz_packages_on_package_id_and_position", unique: true
    t.index ["package_id"], name: "index_quiz_packages_on_package_id"
    t.index ["quiz_id"], name: "index_quiz_packages_on_quiz_id"
  end

  create_table "quizzes", comment: "クイズ", force: :cascade do |t|
    t.text "question", null: false, comment: "質問"
    t.text "description", comment: "説明"
    t.integer "status", default: 0, null: false, comment: "ステータス"
    t.datetime "published_at", comment: "公開日時"
    t.bigint "user_id", null: false
    t.bigint "anime_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["anime_id"], name: "index_quizzes_on_anime_id"
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "choices", "quizzes"
  add_foreign_key "packages", "animes"
  add_foreign_key "packages", "users"
  add_foreign_key "quiz_packages", "choices"
  add_foreign_key "quiz_packages", "packages"
  add_foreign_key "quiz_packages", "quizzes"
  add_foreign_key "quizzes", "animes"
  add_foreign_key "quizzes", "users"
end
