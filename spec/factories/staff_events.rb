# == Schema Information
#
# Table name: staff_events # 職員イベント
#
#  id              :integer          not null, primary key
#  staff_member_id :integer          not null              # 職員レコードへの外部キー
#  type            :string(255)      not null              # イベントタイプ
#  created_at      :datetime         not null              # 発生時刻
#
# Indexes
#
#  index_staff_events_on_created_at                      (created_at)
#  index_staff_events_on_staff_member_id                 (staff_member_id)
#  index_staff_events_on_staff_member_id_and_created_at  (staff_member_id,created_at)
#

FactoryGirl.define do
  factory :staff_event do
    
  end
end
