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

ActiveRecord::Schema.define(version: 20170210034614) do

  create_table "addresses", force: :cascade, comment: "住所" do |t|
    t.integer  "customer_id",                null: false, comment: "顧客への外部キー"
    t.string   "type",                       null: false, comment: "継承カラム"
    t.string   "postal_code",                null: false, comment: "郵便番号"
    t.string   "prefecture",                 null: false, comment: "都道府県"
    t.string   "city",                       null: false, comment: "市区町村"
    t.string   "address1",                   null: false, comment: "町域・番地等"
    t.string   "address2",                   null: false, comment: "建物名・部屋番号"
    t.string   "company_name",  default: "", null: false, comment: "会社名"
    t.string   "division_name", default: "", null: false, comment: "部署名"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["city"], name: "index_addresses_on_city", using: :btree
    t.index ["customer_id"], name: "index_addresses_on_customer_id", using: :btree
    t.index ["postal_code"], name: "index_addresses_on_postal_code", using: :btree
    t.index ["prefecture", "city"], name: "index_addresses_on_prefecture_and_city", using: :btree
    t.index ["type", "city"], name: "index_addresses_on_type_and_city", using: :btree
    t.index ["type", "customer_id"], name: "index_addresses_on_type_and_customer_id", unique: true, using: :btree
    t.index ["type", "prefecture", "city"], name: "index_addresses_on_type_and_prefecture_and_city", using: :btree
  end

  create_table "administrators", force: :cascade, comment: "管理者" do |t|
    t.string   "email",                           null: false, comment: "メールアドレス"
    t.string   "email_for_index",                 null: false, comment: "索引用メールアドレス"
    t.string   "hashed_password",                              comment: "パスワード"
    t.boolean  "suspended",       default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email_for_index"], name: "index_administrators_on_email_for_index", unique: true, using: :btree
  end

  create_table "allowed_sources", force: :cascade, comment: "IPアドレス制限" do |t|
    t.string   "namespace",                  null: false, comment: "名前空間"
    t.integer  "octet1",                     null: false, comment: "第１オクテット"
    t.integer  "octet2",                     null: false, comment: "第２オクテット"
    t.integer  "octet3",                     null: false, comment: "第３オクテット"
    t.integer  "octet4",                     null: false, comment: "第４オクテット"
    t.boolean  "wildcard",   default: false, null: false, comment: "ワイルドカード"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["namespace", "octet1", "octet2", "octet3", "octet4"], name: "index_allowed_sources_on_namespace_and_octets", unique: true, using: :btree
  end

  create_table "customers", force: :cascade, comment: "顧客" do |t|
    t.string   "email",            null: false, comment: "メールアドレス"
    t.string   "email_for_index",  null: false, comment: "顧客用メールアドレス"
    t.string   "family_name",      null: false, comment: "姓"
    t.string   "given_name",       null: false, comment: "名"
    t.string   "family_name_kana", null: false, comment: "姓（カナ）"
    t.string   "given_name_kana",  null: false, comment: "名（カナ）"
    t.string   "gender",                        comment: "性別"
    t.date     "birthday",                      comment: "誕生日"
    t.string   "hashed_password",               comment: "パスワード"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "birth_year",                    comment: "誕生年"
    t.integer  "birth_month",                   comment: "誕生月"
    t.integer  "birth_mday",                    comment: "誕生日"
    t.index ["birth_mday", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_mday_and_furigana", using: :btree
    t.index ["birth_mday", "given_name_kana"], name: "index_customers_on_birth_mday_and_given_name_kana", using: :btree
    t.index ["birth_month", "birth_mday"], name: "index_customers_on_birth_month_and_birth_mday", using: :btree
    t.index ["birth_month", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_month_and_furigana", using: :btree
    t.index ["birth_month", "given_name_kana"], name: "index_customers_on_birth_month_and_given_name_kana", using: :btree
    t.index ["birth_year", "birth_month", "birth_mday"], name: "index_customers_on_birth_year_and_birth_month_and_birth_mday", using: :btree
    t.index ["birth_year", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_year_and_furigana", using: :btree
    t.index ["birth_year", "given_name_kana"], name: "index_customers_on_birth_year_and_given_name_kana", using: :btree
    t.index ["email_for_index"], name: "index_customers_on_email_for_index", unique: true, using: :btree
    t.index ["family_name_kana", "given_name_kana"], name: "index_customers_on_family_name_kana_and_given_name_kana", using: :btree
    t.index ["gender", "family_name_kana", "given_name_kana"], name: "index_customers_on_gender_and_furigana", using: :btree
    t.index ["given_name_kana"], name: "index_customers_on_given_name_kana", using: :btree
  end

  create_table "phones", force: :cascade, comment: "電話" do |t|
    t.integer  "customer_id",                      null: false, comment: "顧客への外部キー"
    t.integer  "address_id",                                    comment: "住所への外部キー"
    t.string   "number",                           null: false, comment: "電話番号"
    t.string   "number_for_index",                 null: false, comment: "索引用電話番号"
    t.boolean  "primary",          default: false, null: false, comment: "優先フラグ"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "last_four_digits",                              comment: "電話番号下４桁"
    t.index ["address_id"], name: "index_phones_on_address_id", using: :btree
    t.index ["customer_id"], name: "index_phones_on_customer_id", using: :btree
    t.index ["last_four_digits"], name: "index_phones_on_last_four_digits", using: :btree
    t.index ["number_for_index"], name: "index_phones_on_number_for_index", using: :btree
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

  add_foreign_key "addresses", "customers"
  add_foreign_key "phones", "addresses"
  add_foreign_key "phones", "customers"
  add_foreign_key "staff_events", "staff_members"
end
