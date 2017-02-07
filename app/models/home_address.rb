# == Schema Information
#
# Table name: addresses # 住所
#
#  id            :integer          not null, primary key
#  customer_id   :integer          not null              # 顧客への外部キー
#  type          :string(255)      not null              # 継承カラム
#  postal_code   :string(255)      not null              # 郵便番号
#  prefecture    :string(255)      not null              # 都道府県
#  city          :string(255)      not null              # 市区町村
#  address1      :string(255)      not null              # 町域・番地等
#  address2      :string(255)      not null              # 建物名・部屋番号
#  company_name  :string(255)      default(""), not null # 会社名
#  division_name :string(255)      default(""), not null # 部署名
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_addresses_on_city                          (city)
#  index_addresses_on_customer_id                   (customer_id)
#  index_addresses_on_prefecture_and_city           (prefecture,city)
#  index_addresses_on_type_and_city                 (type,city)
#  index_addresses_on_type_and_customer_id          (type,customer_id) UNIQUE
#  index_addresses_on_type_and_prefecture_and_city  (type,prefecture,city)
#

class HomeAddress < Address
  validates :postal_code, :prefecture, :city, :address1, presence: true
  validates :company_name, :division_name, absence: true
end
