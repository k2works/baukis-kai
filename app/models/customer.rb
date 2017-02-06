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
#
# Indexes
#
#  index_customers_on_email_for_index                       (email_for_index) UNIQUE
#  index_customers_on_family_name_kana_and_given_name_kana  (family_name_kana,given_name_kana)
#

class Customer < ApplicationRecord
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_one :home_address, dependent: :destroy, autosave: true
  has_one :work_address, dependent: :destroy, autosave: true
  has_many :phones, dependent: :destroy
  has_many :personal_phones, -> { where(address_id: nil).order(:id) },class_name: 'Phone', autosave: true

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
      after: Date.new(1900,1,1),
      before: ->(obj) { Date.today },
      allow_blank: true
  }
end
