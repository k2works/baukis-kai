# == Schema Information
#
# Table name: messages # 問い合わせ
#
#  id              :integer          not null, primary key
#  customer_id     :integer          not null
#  staff_member_id :integer
#  root_id         :integer                                   # Messageへの外部キー
#  parent_id       :integer                                   # Messageへの外部キー
#  type            :string(255)      not null                 # 継承カラム
#  status          :string(255)      default("new"), not null # 状態（職員向け）
#  subject         :string(255)      not null                 # 件名
#  body            :text(65535)                               # 本文
#  remarks         :text(65535)                               # 備考（職員向け）
#  discarded       :boolean          default("0"), not null   # 顧客側の削除フラグ
#  deleted         :boolean          default("0"), not null   # 職員側の削除フラグ
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  fk_rails_aafcb31dbf                                         (parent_id)
#  index_messages_on_c_d_s_c                                   (customer_id,deleted,status,created_at)
#  index_messages_on_customer_id                               (customer_id)
#  index_messages_on_customer_id_and_deleted_and_created_at    (customer_id,deleted,created_at)
#  index_messages_on_customer_id_and_discarded_and_created_at  (customer_id,discarded,created_at)
#  index_messages_on_root_id_and_deleted_and_created_at        (root_id,deleted,created_at)
#  index_messages_on_staff_member_id                           (staff_member_id)
#  index_messages_on_type_and_customer_id                      (type,customer_id)
#  index_messages_on_type_and_staff_member_id                  (type,staff_member_id)
#

FactoryBot.define do
  factory :customer_message do
    subject {'Subject'}
    body {"Body.\nBody."}
    customer
  end

  factory :staff_message do
    subject {'Subject'}
    body {"Body.\nBody."}
    parent { FactoryGirl.create(:customer_message)}
    staff_member
  end
end
