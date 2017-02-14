# == Schema Information
#
# Table name: entries # 申し込み
#
#  id          :integer          not null, primary key
#  program_id  :integer          not null
#  customer_id :integer          not null
#  approved    :boolean          default("0"), not null # 承認済みフラグ
#  canceled    :boolean          default("0"), not null # 取り消しフラグ
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_entries_on_customer_id                 (customer_id)
#  index_entries_on_program_id                  (program_id)
#  index_entries_on_program_id_and_customer_id  (program_id,customer_id) UNIQUE
#

FactoryGirl.define do
  factory :entry do
    
  end
end
