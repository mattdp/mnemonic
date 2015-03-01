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

ActiveRecord::Schema.define(version: 20150301203312) do

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

  create_table "events", force: true do |t|
    t.date     "start_date"
    t.date     "fade_date"
    t.string   "fade_action"
    t.boolean  "dismissed",      default: false
    t.string   "content"
    t.text     "notes"
    t.string   "event_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "year"
    t.date     "happening_date"
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
  end

  create_table "questions", force: true do |t|
    t.string   "ask"
    t.string   "answer_type"
    t.integer  "ordering",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.text     "self_assessment"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "verbs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
