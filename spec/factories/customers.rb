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

FactoryGirl.define do
  factory :customer do
    
  end
end
