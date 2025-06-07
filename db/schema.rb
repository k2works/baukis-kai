# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2017_03_27_081649) do
  create_table "addresses", id: :integer, charset: "utf8mb3", comment: "住所", force: :cascade do |t|
    t.integer "customer_id", null: false, comment: "顧客への外部キー"
    t.string "type", null: false, comment: "継承カラム"
    t.string "postal_code", null: false, comment: "郵便番号"
    t.string "prefecture", null: false, comment: "都道府県"
    t.string "city", null: false, comment: "市区町村"
    t.string "address1", null: false, comment: "町域・番地等"
    t.string "address2", null: false, comment: "建物名・部屋番号"
    t.string "company_name", default: "", null: false, comment: "会社名"
    t.string "division_name", default: "", null: false, comment: "部署名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_addresses_on_city"
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
    t.index ["postal_code"], name: "index_addresses_on_postal_code"
    t.index ["prefecture", "city"], name: "index_addresses_on_prefecture_and_city"
    t.index ["type", "city"], name: "index_addresses_on_type_and_city"
    t.index ["type", "customer_id"], name: "index_addresses_on_type_and_customer_id", unique: true
    t.index ["type", "prefecture", "city"], name: "index_addresses_on_type_and_prefecture_and_city"
  end

  create_table "administrators", id: :integer, charset: "utf8mb3", comment: "管理者", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "email_for_index", null: false, comment: "索引用メールアドレス"
    t.string "hashed_password", comment: "パスワード"
    t.boolean "suspended", default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_for_index"], name: "index_administrators_on_email_for_index", unique: true
  end

  create_table "allowed_sources", id: :integer, charset: "utf8mb3", comment: "IPアドレス制限", force: :cascade do |t|
    t.string "namespace", null: false, comment: "名前空間"
    t.integer "octet1", null: false, comment: "第１オクテット"
    t.integer "octet2", null: false, comment: "第２オクテット"
    t.integer "octet3", null: false, comment: "第３オクテット"
    t.integer "octet4", null: false, comment: "第４オクテット"
    t.boolean "wildcard", default: false, null: false, comment: "ワイルドカード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["namespace", "octet1", "octet2", "octet3", "octet4"], name: "index_allowed_sources_on_namespace_and_octets", unique: true
  end

  create_table "customers", id: :integer, charset: "utf8mb3", comment: "顧客", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "email_for_index", null: false, comment: "顧客用メールアドレス"
    t.string "family_name", null: false, comment: "姓"
    t.string "given_name", null: false, comment: "名"
    t.string "family_name_kana", null: false, comment: "姓（カナ）"
    t.string "given_name_kana", null: false, comment: "名（カナ）"
    t.string "gender", comment: "性別"
    t.date "birthday", comment: "誕生日"
    t.string "hashed_password", comment: "パスワード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "birth_year", comment: "誕生年"
    t.integer "birth_month", comment: "誕生月"
    t.integer "birth_mday", comment: "誕生日"
    t.index ["birth_mday", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_mday_and_furigana"
    t.index ["birth_mday", "given_name_kana"], name: "index_customers_on_birth_mday_and_given_name_kana"
    t.index ["birth_month", "birth_mday"], name: "index_customers_on_birth_month_and_birth_mday"
    t.index ["birth_month", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_month_and_furigana"
    t.index ["birth_month", "given_name_kana"], name: "index_customers_on_birth_month_and_given_name_kana"
    t.index ["birth_year", "birth_month", "birth_mday"], name: "index_customers_on_birth_year_and_birth_month_and_birth_mday"
    t.index ["birth_year", "family_name_kana", "given_name_kana"], name: "index_customers_on_birth_year_and_furigana"
    t.index ["birth_year", "given_name_kana"], name: "index_customers_on_birth_year_and_given_name_kana"
    t.index ["email_for_index"], name: "index_customers_on_email_for_index", unique: true
    t.index ["family_name_kana", "given_name_kana"], name: "index_customers_on_family_name_kana_and_given_name_kana"
    t.index ["gender", "family_name_kana", "given_name_kana"], name: "index_customers_on_gender_and_furigana"
    t.index ["given_name_kana"], name: "index_customers_on_given_name_kana"
  end

  create_table "entries", id: :integer, charset: "utf8mb3", comment: "申し込み", force: :cascade do |t|
    t.integer "program_id", null: false
    t.integer "customer_id", null: false
    t.boolean "approved", default: false, null: false, comment: "承認済みフラグ"
    t.boolean "canceled", default: false, null: false, comment: "取り消しフラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_entries_on_customer_id"
    t.index ["program_id", "customer_id"], name: "index_entries_on_program_id_and_customer_id", unique: true
    t.index ["program_id"], name: "index_entries_on_program_id"
  end

  create_table "hash_locks", id: :integer, charset: "utf8mb3", comment: "排他制御", force: :cascade do |t|
    t.string "table", null: false, comment: "テーブル"
    t.string "column", null: false, comment: "カラム"
    t.string "key", null: false, comment: "キー"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table", "column", "key"], name: "index_hash_locks_on_table_and_column_and_key", unique: true
  end

  create_table "message_tag_links", id: :integer, charset: "utf8mb3", comment: "タグリンクテーブル", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "tag_id", null: false
    t.index ["message_id", "tag_id"], name: "index_message_tag_links_on_message_id_and_tag_id", unique: true
    t.index ["message_id"], name: "index_message_tag_links_on_message_id"
    t.index ["tag_id"], name: "index_message_tag_links_on_tag_id"
  end

  create_table "messages", id: :integer, charset: "utf8mb3", comment: "問い合わせ", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "staff_member_id"
    t.integer "root_id", comment: "Messageへの外部キー"
    t.integer "parent_id", comment: "Messageへの外部キー"
    t.string "type", null: false, comment: "継承カラム"
    t.string "status", default: "new", null: false, comment: "状態（職員向け）"
    t.string "subject", null: false, comment: "件名"
    t.text "body", comment: "本文"
    t.text "remarks", comment: "備考（職員向け）"
    t.boolean "discarded", default: false, null: false, comment: "顧客側の削除フラグ"
    t.boolean "deleted", default: false, null: false, comment: "職員側の削除フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "deleted", "created_at"], name: "index_messages_on_customer_id_and_deleted_and_created_at"
    t.index ["customer_id", "deleted", "status", "created_at"], name: "index_messages_on_c_d_s_c"
    t.index ["customer_id", "discarded", "created_at"], name: "index_messages_on_customer_id_and_discarded_and_created_at"
    t.index ["customer_id"], name: "index_messages_on_customer_id"
    t.index ["parent_id"], name: "fk_rails_aafcb31dbf"
    t.index ["root_id", "deleted", "created_at"], name: "index_messages_on_root_id_and_deleted_and_created_at"
    t.index ["staff_member_id"], name: "index_messages_on_staff_member_id"
    t.index ["type", "customer_id"], name: "index_messages_on_type_and_customer_id"
    t.index ["type", "staff_member_id"], name: "index_messages_on_type_and_staff_member_id"
  end

  create_table "phones", id: :integer, charset: "utf8mb3", comment: "電話", force: :cascade do |t|
    t.integer "customer_id", null: false, comment: "顧客への外部キー"
    t.integer "address_id", comment: "住所への外部キー"
    t.string "number", null: false, comment: "電話番号"
    t.string "number_for_index", null: false, comment: "索引用電話番号"
    t.boolean "primary", default: false, null: false, comment: "優先フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_four_digits", comment: "電話番号下４桁"
    t.index ["address_id"], name: "index_phones_on_address_id"
    t.index ["customer_id"], name: "index_phones_on_customer_id"
    t.index ["last_four_digits"], name: "index_phones_on_last_four_digits"
    t.index ["number_for_index"], name: "index_phones_on_number_for_index"
  end

  create_table "programs", id: :integer, charset: "utf8mb3", comment: "プログラム", force: :cascade do |t|
    t.integer "registrant_id", null: false, comment: "登録職員（外部キー）"
    t.string "title", null: false, comment: "タイトル"
    t.text "description", comment: "説明"
    t.datetime "application_start_time", null: false, comment: "申し込み開始日"
    t.datetime "application_end_time", null: false, comment: "申し込み終了日"
    t.integer "min_number_of_participants", comment: "最小参観者数"
    t.integer "max_number_of_participants", comment: "最大参観者数"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_start_time"], name: "index_programs_on_application_start_time"
    t.index ["registrant_id"], name: "index_programs_on_registrant_id"
  end

  create_table "staff_events", id: :integer, charset: "utf8mb3", comment: "職員イベント", force: :cascade do |t|
    t.integer "staff_member_id", null: false, comment: "職員レコードへの外部キー"
    t.string "type", null: false, comment: "イベントタイプ"
    t.datetime "created_at", null: false, comment: "発生時刻"
    t.index ["created_at"], name: "index_staff_events_on_created_at"
    t.index ["staff_member_id", "created_at"], name: "index_staff_events_on_staff_member_id_and_created_at"
    t.index ["staff_member_id"], name: "index_staff_events_on_staff_member_id"
  end

  create_table "staff_members", id: :integer, charset: "utf8mb3", comment: "職員", force: :cascade do |t|
    t.string "email", null: false, comment: "メールアドレス"
    t.string "email_for_index", null: false, comment: "索引用メールアドレス"
    t.string "family_name", null: false, comment: "姓"
    t.string "given_name", null: false, comment: "名"
    t.string "family_name_kana", null: false, comment: "姓（カナ）"
    t.string "given_name_kana", null: false, comment: "名（カナ）"
    t.string "hashed_password", comment: "パスワード"
    t.date "start_date", null: false, comment: "開始日"
    t.date "end_date", comment: "終了日"
    t.boolean "suspended", default: false, null: false, comment: "停止フラグ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_for_index"], name: "index_staff_members_on_email_for_index", unique: true
    t.index ["family_name_kana", "given_name_kana"], name: "index_staff_members_on_family_name_kana_and_given_name_kana"
  end

  create_table "tags", id: :integer, charset: "utf8mb3", comment: "タグ", force: :cascade do |t|
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["value"], name: "index_tags_on_value", unique: true
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "entries", "customers"
  add_foreign_key "entries", "programs"
  add_foreign_key "messages", "customers"
  add_foreign_key "messages", "messages", column: "parent_id"
  add_foreign_key "messages", "messages", column: "root_id"
  add_foreign_key "messages", "staff_members"
  add_foreign_key "phones", "addresses"
  add_foreign_key "phones", "customers"
  add_foreign_key "programs", "staff_members", column: "registrant_id"
  add_foreign_key "staff_events", "staff_members"
end
