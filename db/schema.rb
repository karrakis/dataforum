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

ActiveRecord::Schema.define(version: 20171116152404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forum_posts", force: :cascade do |t|
    t.integer  "users_id"
    t.integer  "graphs_id"
    t.integer  "parent_id"
    t.text     "post_contents"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["graphs_id"], name: "index_forum_posts_on_graphs_id", using: :btree
    t.index ["parent_id"], name: "index_forum_posts_on_parent_id", using: :btree
    t.index ["users_id"], name: "index_forum_posts_on_users_id", using: :btree
  end

  create_table "graphs", force: :cascade do |t|
    t.integer  "users_id"
    t.string   "graph_label"
    t.string   "graph_type"
    t.string   "data_source_file_name"
    t.string   "data_source_content_type"
    t.integer  "data_source_file_size"
    t.string   "x_field"
    t.string   "y_field"
    t.text     "separator_fields"
    t.boolean  "deleted"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "data_json"
    t.text     "embed_link"
    t.text     "direct_link"
    t.index ["users_id"], name: "index_graphs_on_users_id", using: :btree
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string   "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "auth_token"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "gauth_secret"
    t.string   "gauth_enabled",          default: "f"
    t.string   "gauth_tmp"
    t.datetime "gauth_tmp_datetime"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "forum_posts", "graphs", column: "graphs_id"
  add_foreign_key "forum_posts", "users", column: "users_id"
end
