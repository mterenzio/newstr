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

ActiveRecord::Schema[7.0].define(version: 2023_10_21_222840) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "url", null: false
    t.jsonb "linked_data"
    t.jsonb "metadata"
    t.integer "share_count"
    t.string "title"
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "source_articles", force: :cascade do |t|
    t.bigint "source_id"
    t.bigint "article_id"
    t.jsonb "note"
    t.boolean "repost", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_source_articles_on_article_id"
    t.index ["source_id", "article_id"], name: "index_source_articles_on_source_id_and_article_id", unique: true
    t.index ["source_id"], name: "index_source_articles_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "public_key", null: false
    t.jsonb "profile"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_sources", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_user_sources_on_source_id"
    t.index ["user_id", "source_id"], name: "index_user_sources_on_user_id_and_source_id", unique: true
    t.index ["user_id"], name: "index_user_sources_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "public_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "source_articles", "articles"
  add_foreign_key "source_articles", "sources"
  add_foreign_key "user_sources", "sources"
  add_foreign_key "user_sources", "users"
end
