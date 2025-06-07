# == Schema Information
#
# Table name: phones # 電話
#
#  id               :integer          not null, primary key
#  customer_id      :integer          not null               # 顧客への外部キー
#  address_id       :integer                                 # 住所への外部キー
#  number           :string(255)      not null               # 電話番号
#  number_for_index :string(255)      not null               # 索引用電話番号
#  primary          :boolean          default("0"), not null # 優先フラグ
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  last_four_digits :string(255)                             # 電話番号下４桁
#
# Indexes
#
#  index_phones_on_address_id        (address_id)
#  index_phones_on_customer_id       (customer_id)
#  index_phones_on_last_four_digits  (last_four_digits)
#  index_phones_on_number_for_index  (number_for_index)
#

FactoryBot.define do
  factory :phone do
    
  end
end
