# == Schema Information
#
# Table name: allowed_sources # IPアドレス制限
#
#  id         :integer          not null, primary key
#  namespace  :string(255)      not null               # 名前空間
#  octet1     :integer          not null               # 第１オクテット
#  octet2     :integer          not null               # 第２オクテット
#  octet3     :integer          not null               # 第３オクテット
#  octet4     :integer          not null               # 第４オクテット
#  wildcard   :boolean          default("0"), not null # ワイルドカード
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_allowed_sources_on_namespace_and_octets  (namespace,octet1,octet2,octet3,octet4) UNIQUE
#

FactoryGirl.define do
  factory :allowed_source do
    
  end
end
