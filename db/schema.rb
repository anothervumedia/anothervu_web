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

ActiveRecord::Schema.define(version: 20180411232450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_comments_on_project_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hearts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", default: "2018-03-18 18:07:20", null: false
    t.datetime "updated_at", default: "2018-03-18 18:07:20", null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_hearts_on_project_id"
    t.index ["user_id"], name: "index_hearts_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hearts_count", default: 0
    t.string "location"
    t.string "category"
    t.string "designer"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "uploads", force: :cascade do |t|
    t.string "image"
    t.string "video"
    t.datetime "created_at", default: "2018-03-18 18:07:20", null: false
    t.datetime "updated_at", default: "2018-03-18 18:07:20", null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_uploads_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.text "biography"
    t.string "phone_number"
    t.string "website"
    t.boolean "admin"
    t.boolean "email_show", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "projects"
  add_foreign_key "comments", "users"
  add_foreign_key "hearts", "projects"
  add_foreign_key "hearts", "users"
  add_foreign_key "projects", "users", on_delete: :cascade
  add_foreign_key "uploads", "projects"
end
