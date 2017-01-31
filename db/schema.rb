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

ActiveRecord::Schema.define(version: 20170131041629) do

  create_table "administrators", force: :cascade, comment: "管理者" do |t|
    t.string   "email",                           null: false, comment: "メールアドレス"
    t.string   "email_for_index",                 null: false, comment: "索引用メールアドレス"
    t.string   "hashed_password",                              comment: "パスワード"
    t.boolean  "suspended",       default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email_for_index"], name: "index_administrators_on_email_for_index", unique: true, using: :btree
  end

  create_table "staff_events", force: :cascade, comment: "職員イベント" do |t|
    t.integer  "staff_member_id", null: false, comment: "職員レコードへの外部キー"
    t.string   "type",            null: false, comment: "イベントタイプ"
    t.datetime "created_at",      null: false, comment: "発生時刻"
    t.index ["created_at"], name: "index_staff_events_on_created_at", using: :btree
    t.index ["staff_member_id", "created_at"], name: "index_staff_events_on_staff_member_id_and_created_at", using: :btree
    t.index ["staff_member_id"], name: "index_staff_events_on_staff_member_id", using: :btree
  end

  create_table "staff_members", force: :cascade, comment: "職員" do |t|
    t.string   "email",                            null: false, comment: "メールアドレス"
    t.string   "email_for_index",                  null: false, comment: "索引用メールアドレス"
    t.string   "family_name",                      null: false, comment: "姓"
    t.string   "given_name",                       null: false, comment: "名"
    t.string   "family_name_kana",                 null: false, comment: "姓（カナ）"
    t.string   "given_name_kana",                  null: false, comment: "名（カナ）"
    t.string   "hashed_password",                               comment: "パスワード"
    t.date     "start_date",                       null: false, comment: "開始日"
    t.date     "end_date",                                      comment: "終了日"
    t.boolean  "suspended",        default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["email_for_index"], name: "index_staff_members_on_email_for_index", unique: true, using: :btree
    t.index ["family_name_kana", "given_name_kana"], name: "index_staff_members_on_family_name_kana_and_given_name_kana", using: :btree
  end

  add_foreign_key "staff_events", "staff_members"
end
