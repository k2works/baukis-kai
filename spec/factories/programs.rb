# == Schema Information
#
# Table name: programs # プログラム
#
#  id                         :integer          not null, primary key
#  registrant_id              :integer          not null              # 登録職員（外部キー）
#  title                      :string(255)      not null              # タイトル
#  description                :text(65535)                            # 説明
#  application_start_time     :datetime         not null              # 申し込み開始日
#  application_end_time       :datetime         not null              # 申し込み終了日
#  min_number_of_participants :integer                                # 最小参観者数
#  max_number_of_participants :integer                                # 最大参観者数
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_programs_on_application_start_time  (application_start_time)
#  index_programs_on_registrant_id           (registrant_id)
#

FactoryBot.define do
  factory :program do
    title {'Title'}
    description {'Description'}
    application_start_time { 5.days.ago.midnight }
    application_end_time { 2.days.from_now.midnight }
    min_number_of_participants {5}
    max_number_of_participants {10}
    registrant { create(:staff_member) }
  end
end
