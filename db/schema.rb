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

ActiveRecord::Schema.define(version: 20170523072146) do

  create_table "airports", force: :cascade do |t|
    t.string "airport", limit: 255
  end

  create_table "currencies", force: :cascade do |t|
    t.string "currency", limit: 255
    t.string "image",    limit: 255
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "propose_id", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "likes", ["propose_id"], name: "index_likes_on_propose_id", using: :btree
  add_index "likes", ["user_id", "propose_id"], name: "index_likes_on_user_id_and_propose_id", unique: true, using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "room_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "messages", ["room_id"], name: "index_messages_on_room_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "proposes", force: :cascade do |t|
    t.text     "comment",          limit: 65535
    t.integer  "amount",           limit: 4
    t.integer  "have_currency_id", limit: 4,     null: false
    t.integer  "want_currency_id", limit: 4,     null: false
    t.integer  "user_id",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "likes_count",      limit: 4
    t.text     "gotime",           limit: 65535
    t.integer  "airport_id",       limit: 4
  end

  add_index "proposes", ["airport_id"], name: "index_proposes_on_airport_id", using: :btree
  add_index "proposes", ["have_currency_id"], name: "index_proposes_on_have_currency_id", using: :btree
  add_index "proposes", ["user_id"], name: "index_proposes_on_user_id", using: :btree
  add_index "proposes", ["want_currency_id"], name: "index_proposes_on_want_currency_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "request_matches", force: :cascade do |t|
    t.integer  "post_user_id",    limit: 4
    t.integer  "request_user_id", limit: 4
    t.integer  "propose_id",      limit: 4
    t.boolean  "negotiated",                default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "request_matches", ["post_user_id"], name: "index_request_matches_on_post_user_id", using: :btree
  add_index "request_matches", ["propose_id"], name: "index_request_matches_on_propose_id", using: :btree
  add_index "request_matches", ["propose_id"], name: "propose_id_must_be_unique", unique: true, using: :btree
  add_index "request_matches", ["request_user_id", "propose_id"], name: "index_request_matches_on_request_user_id_and_propose_id", unique: true, using: :btree
  add_index "request_matches", ["request_user_id"], name: "index_request_matches_on_request_user_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.integer  "requestman_id", limit: 4
    t.integer  "postman_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "propose_id",    limit: 4
  end

  add_index "rooms", ["postman_id"], name: "index_rooms_on_postman_id", using: :btree
  add_index "rooms", ["propose_id"], name: "index_rooms_on_propose_id", using: :btree
  add_index "rooms", ["requestman_id", "propose_id"], name: "index_rooms_on_requestman_id_and_propose_id", unique: true, using: :btree
  add_index "rooms", ["requestman_id"], name: "index_rooms_on_requestman_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "password_digest",   limit: 255
    t.string   "remember_digest",   limit: 255
    t.boolean  "admin",                         default: false
    t.string   "activation_digest", limit: 255
    t.boolean  "activated",                     default: false
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
    t.datetime "reset_sent_at"
    t.string   "image",             limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "likes", "proposes"
  add_foreign_key "likes", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "proposes", "airports"
  add_foreign_key "proposes", "users"
  add_foreign_key "request_matches", "proposes"
  add_foreign_key "rooms", "proposes"
end
