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

ActiveRecord::Schema.define(version: 20140924150248) do

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "isbn"
    t.integer  "wanted",     default: 0, null: false
    t.integer  "read",       default: 0, null: false
    t.integer  "rental",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn", unique: true
  add_index "books", ["title"], name: "index_books_on_title"

  create_table "news", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
