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

ActiveRecord::Schema.define(version: 20150117082634) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "asin"
    t.integer  "wanted",     default: 0, null: false
    t.integer  "read",       default: 0, null: false
    t.integer  "rental",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "book_cover"
  end

  add_index "books", ["asin"], name: "index_books_on_asin", unique: true
  add_index "books", ["title"], name: "index_books_on_title"

  create_table "collections", force: true do |t|
    t.integer  "status"
    t.date     "rented_at"
    t.date     "returned_at"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["book_id"], name: "index_collections_on_book_id"
  add_index "collections", ["user_id", "book_id"], name: "index_collections_on_user_id_and_book_id", unique: true
  add_index "collections", ["user_id"], name: "index_collections_on_user_id"

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "user_name"
    t.string   "category"
    t.text     "content"
    t.boolean  "deal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.string   "title"
    t.text     "content"
    t.integer  "evaluation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "collection_id"
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name",                           null: false
    t.string   "email",                          null: false
    t.string   "password_digest",                null: false
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "remember_token"
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.integer  "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
