# == Schema Information
#
# Table name: customers # 顧客
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null              # メールアドレス
#  email_for_index  :string(255)      not null              # 顧客用メールアドレス
#  family_name      :string(255)      not null              # 姓
#  given_name       :string(255)      not null              # 名
#  family_name_kana :string(255)      not null              # 姓（カナ）
#  given_name_kana  :string(255)      not null              # 名（カナ）
#  gender           :string(255)                            # 性別
#  birthday         :date                                   # 誕生日
#  hashed_password  :string(255)                            # パスワード
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  birth_year       :integer                                # 誕生年
#  birth_month      :integer                                # 誕生月
#  birth_mday       :integer                                # 誕生日
#
# Indexes
#
#  index_customers_on_birth_mday_and_furigana                    (birth_mday,family_name_kana,given_name_kana)
#  index_customers_on_birth_mday_and_given_name_kana             (birth_mday,given_name_kana)
#  index_customers_on_birth_month_and_birth_mday                 (birth_month,birth_mday)
#  index_customers_on_birth_month_and_furigana                   (birth_month,family_name_kana,given_name_kana)
#  index_customers_on_birth_month_and_given_name_kana            (birth_month,given_name_kana)
#  index_customers_on_birth_year_and_birth_month_and_birth_mday  (birth_year,birth_month,birth_mday)
#  index_customers_on_birth_year_and_furigana                    (birth_year,family_name_kana,given_name_kana)
#  index_customers_on_birth_year_and_given_name_kana             (birth_year,given_name_kana)
#  index_customers_on_email_for_index                            (email_for_index) UNIQUE
#  index_customers_on_family_name_kana_and_given_name_kana       (family_name_kana,given_name_kana)
#  index_customers_on_gender_and_furigana                        (gender,family_name_kana,given_name_kana)
#  index_customers_on_given_name_kana                            (given_name_kana)
#

class Customer < ApplicationRecord
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_many :addresses, dependent: :destroy
  has_one :home_address, autosave: true
  has_one :work_address, autosave: true
  has_many :phones, dependent: :destroy
  has_many :personal_phones, -> { where(address_id: nil).order(:id) },class_name: 'Phone', autosave: true
  has_many :entries, dependent: :destroy
  has_many :programs, through: :entries
  has_many :messages
  has_many :outbound_messages, class_name: 'CustomerMessage', foreign_key: 'customer_id'
  has_many :inbound_messages, class_name: 'StaffMember', foreign_key: 'customer_id'

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
      after: Date.new(1900,1,1),
      before: ->(obj) { Date.today },
      allow_blank: true
  }

  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end
end
