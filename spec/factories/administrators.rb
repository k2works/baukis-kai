# == Schema Information
#
# Table name: administrators # 管理者
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null               # メールアドレス
#  email_for_index :string(255)      not null               # 索引用メールアドレス
#  hashed_password :string(255)                             # パスワード
#  suspended       :boolean          default("0"), not null # 停止フラグ
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_administrators_on_email_for_index  (email_for_index) UNIQUE
#

FactoryBot.define do
  factory :administrator do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password {'pw'}
    suspended {false}
  end
end
