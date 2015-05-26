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

ActiveRecord::Schema.define(version: 20150526202418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "survey_id"
    t.integer  "question_id"
    t.text     "content_text"
    t.integer  "content_integer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communications", force: true do |t|
    t.integer  "person_id"
    t.string   "medium"
    t.date     "when"
    t.text     "contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deeds", force: true do |t|
    t.boolean  "accomplished"
    t.integer  "minutes"
    t.integer  "before_survey_id"
    t.integer  "after_survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plan_id"
  end

  create_table "events", force: true do |t|
    t.date     "start_date"
    t.date     "fade_date"
    t.string   "fade_action"
    t.boolean  "dismissed",        default: false
    t.string   "content"
    t.text     "notes"
    t.string   "event_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "year"
    t.date     "happening_date"
    t.string   "dismissed_reason"
  end

  create_table "people", force: true do |t|
    t.date     "birthday"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.string   "url_linkedin"
    t.string   "url_facebook"
    t.string   "name"
    t.string   "phone"
    t.integer  "relationship_current"
    t.integer  "relationship_possible"
    t.integer  "reminder_days"
    t.boolean  "reminder_manual_override"
  end

  create_table "plans", force: true do |t|
    t.string   "name"
    t.text     "notes"
    t.integer  "minimum_minutes"
    t.boolean  "seems_purposeful"
    t.boolean  "requires_alertness"
    t.boolean  "seems_fun"
    t.boolean  "repeater"
    t.boolean  "dismissed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "ask"
    t.string   "answer_type"
    t.integer  "ordering",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "surveys", force: true do |t|
    t.text     "self_assessment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "verb_id"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "name_for_link"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "verbs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
