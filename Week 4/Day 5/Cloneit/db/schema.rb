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

ActiveRecord::Schema.define(version: 20150717180945) do

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.integer  "parent_id"
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.integer  "author_id",  null: false
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id"

  create_table "session_tokens", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "session_tokens", ["value"], name: "index_session_tokens_on_value", unique: true

  create_table "sub_links", force: :cascade do |t|
    t.integer  "post_id",    null: false
    t.integer  "sub_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sub_links", ["post_id"], name: "index_sub_links_on_post_id"
  add_index "sub_links", ["sub_id"], name: "index_sub_links_on_sub_id"

  create_table "subs", force: :cascade do |t|
    t.integer  "moderator_id", null: false
    t.string   "title",        null: false
    t.text     "description",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
