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

ActiveRecord::Schema.define(version: 20170825212317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "auth_token"
    t.string   "email"
    t.string   "phone"
    t.timestamps
  end

  create_table "graphs", force: :cascade do |t|
    t.belongs_to "users"
    t.string     "graph_label"
    t.string     "graph_type"
    t.string     "data_source_file_name"
    t.string     "data_source_content_type"
    t.integer    "data_source_file_size"
    t.string     "x_field"
    t.string     "y_field"
    t.text       "separator_fields"
    t.boolean    "deleted"
    t.timestamps
  end

  create_table "forum_posts", force: :cascade do |t|
    t.belongs_to "users", index: true, foreign_key: "id"
    t.belongs_to "graphs", index: true, foreign_key: "id"
    t.references :parent, index: true
    t.text "post_contents"
    t.timestamps
  end

end
